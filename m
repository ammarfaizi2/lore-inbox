Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263237AbSJCLOS>; Thu, 3 Oct 2002 07:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263238AbSJCLOR>; Thu, 3 Oct 2002 07:14:17 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:2834 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263237AbSJCLOO>; Thu, 3 Oct 2002 07:14:14 -0400
Date: Thu, 3 Oct 2002 13:17:30 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] linux kernel conf 0.6
In-Reply-To: <Pine.LNX.4.44.0209221727290.11808-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0210031259120.338-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(I almost forgot to reply to this one, sorry for the delay.)

On Sun, 22 Sep 2002, Kai Germaschewski wrote:

> I'm not particularly fond of these md5sum hacks. I don't think it's all
> that annoying for the developer, either, it's basically just a
> alias make="make LKC_GENPARSER=1"
>
> (Of course, you'll have to update the _shipped files eventually, but there
> isn't really any way around that either way)

Where's the problem with md5sum? If the rules are usually not visible
anyway, why do we use the _shipped postfix at all? The depencies are
hidden this way as well, so make won't even try to regenerate the file.
The developer has to remember that extra argument to get the file
regenerated, what is IMO more hacky than using md5sum.

bye, Roman

