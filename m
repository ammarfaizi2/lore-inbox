Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264908AbTB0NBO>; Thu, 27 Feb 2003 08:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264915AbTB0NBO>; Thu, 27 Feb 2003 08:01:14 -0500
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:21964 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S264908AbTB0NBN>; Thu, 27 Feb 2003 08:01:13 -0500
Date: Thu, 27 Feb 2003 13:14:06 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Jonathan Lundell <linux@lundell-bros.com>
Cc: Alan Cox <alan@redhat.com>, Kimball Brown <kimball@serverworks.com>,
       davej@codemonkey.org.uk, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: Tighten up serverworks workaround.
Message-ID: <20030227131406.Q629@nightmaster.csn.tu-chemnitz.de>
References: <200302261803.h1QI3BT24020@devserv.devel.redhat.com> <p05210508ba82bc0ea504@[207.213.214.37]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <p05210508ba82bc0ea504@[207.213.214.37]>; from linux@lundell-bros.com on Wed, Feb 26, 2003 at 10:47:52AM -0800
X-Spam-Score: -32.5 (--------------------------------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18oNox-0007Oj-00*7roVodneW4A*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,

On Wed, Feb 26, 2003 at 10:47:52AM -0800, Jonathan Lundell wrote:
> At 1:03pm -0500 2/26/03, Alan Cox wrote:
> >  > How can e help?  Please give me a configuration and how the bug manifests
> >>  inself.
> >
> >OSB4 chipset system, some memory areas marked write combining with the
> >processor memory type range registers. A long time ago Dell (I
> >think) reported corruption from this and submitted changes to block the
> >use of write combining on OSB4. The question has arisen as to whether
> >thats a known thing, and if so which release of the chipset fixed it so that
> >people can only apply such a restriction to problem cases not all OSB4.
> 
> Presumably we're talking about CNB30 (the north bridge) rather than 
> OSB4 (the south bridge).

No it's about CNB20LE. I'm one of the low performance victims.
And this is an ASUS board (CUR-DLS) (which proved not worth its
prices recently).

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
