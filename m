Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267916AbTAMR4D>; Mon, 13 Jan 2003 12:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267929AbTAMR4D>; Mon, 13 Jan 2003 12:56:03 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:38151 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267916AbTAMR4B>;
	Mon, 13 Jan 2003 12:56:01 -0500
Date: Mon, 13 Jan 2003 19:04:50 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>, ebiederm@xmission.com
Cc: linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [RFC] Consolidate vmlinux.lds.S files
Message-ID: <20030113180450.GA1870@mars.ravnborg.org>
Mail-Followup-To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	ebiederm@xmission.com, linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
References: <20030112220741.GA15849@mars.ravnborg.org> <20030113003632.J628@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030113003632.J628@nightmaster.csn.tu-chemnitz.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 12:36:32AM +0100, Ingo Oeser wrote:
> Hi,
> 
> > This is first version, where I have converted i386, s390 and sparc64.
> > The latter two is not tested, only to make sure it can be used by more
> > than one platform.
> 
> Liker scripts are hard enough to read, so I would not like to see
> more CPP magic here. Consolidation should stop, where the
> readability stops.

Hi Ingo & Eric.

The purpose was to define common stuff in a single place.
Ask Rusty Russell if it is fun to add the same section to > 50
.lds files.

Based on the feedback I will try to come up with a lighter proposal,
that does not hurt readability.
I still want the common stuff separated away.

And I will in the process try to add a bit more descriptive comments,
I agree the linker scripts are hard to read today. It would help if people
cared to spend a few more lines explaning the actual usage.
Having such explanation in a common place would make the chances for
an update of the comments bigger.

	Sam
