Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267991AbTAMG7v>; Mon, 13 Jan 2003 01:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268267AbTAMG7t>; Mon, 13 Jan 2003 01:59:49 -0500
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:45197 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S267991AbTAMG7p>; Mon, 13 Jan 2003 01:59:45 -0500
Date: Mon, 13 Jan 2003 00:36:32 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [RFC] Consolidate vmlinux.lds.S files
Message-ID: <20030113003632.J628@nightmaster.csn.tu-chemnitz.de>
References: <20030112220741.GA15849@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20030112220741.GA15849@mars.ravnborg.org>; from sam@ravnborg.org on Sun, Jan 12, 2003 at 11:07:41PM +0100
X-Spam-Score: -2.9 (--)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18Xyi2-0007Sd-00*W9u1wkK.d7Q*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jan 12, 2003 at 11:07:41PM +0100, Sam Ravnborg wrote:
> Recently we have seen seveal changes to arch/*/vmlinux-lds.S,
> mainly introduced by the module support but also other changes.
> 
> This is first version, where I have converted i386, s390 and sparc64.
> The latter two is not tested, only to make sure it can be used by more
> than one platform.

Liker scripts are hard enough to read, so I would not like to see
more CPP magic here. Consolidation should stop, where the
readability stops.

These files are not too big, are they?

I'm willing to pay some minutes more of download time[1], if what I
get remains readable ;-)

Regards

Ingo Oeser

[1] 33.6K modem
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
