Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267023AbTAZW0V>; Sun, 26 Jan 2003 17:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267025AbTAZW0V>; Sun, 26 Jan 2003 17:26:21 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:8703 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S267023AbTAZW0U>; Sun, 26 Jan 2003 17:26:20 -0500
Date: Mon, 27 Jan 2003 00:28:39 +0100
From: Christian Zander <zander@minion.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Christian Zander <zander@minion.de>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel.
Message-ID: <20030126232839.GF394@kugai>
Reply-To: Christian Zander <zander@minion.de>
References: <20030126220842.GB394@kugai> <20030123193540.GD13137@ca-server1.us.oracle.com> <Pine.LNX.4.44.0301261054250.15538-100000@chaos.physics.uiowa.edu> <28922.1043617222@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28922.1043617222@passion.cambridge.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2003 at 09:40:22PM +0000, David Woodhouse wrote:
> 
> That's what EXTRA_CFLAGS and CFLAGS_someobject.o are for.
> 

I am well aware of the documentation in Documentation/kbuild and know
that kbuild is flexible enough to support customized CFLAGS. I didn't
argue that.

> The use of the kernel build process to build kernel modules is not
> _mandatory_, it's just that it's the only sane option.
> 
> You are, of course, welcome to hack up your own broken and
> short-term solutions which happen to work this week for some
> platforms. But don't come crying to us when (not if) they stop
> working.
> 
> The use of vermagic.c doesn't stop you from making your own build
> system; you can have your own vermagic.c to make your hacks work
> this week.
> 

I can't follow your hostility in this matter; I didn't "come crying"
to you when things broke in the past and I'm not crying now. Last time
I checked, voicing concerns was a legitimate thing to do.

The "broken and short-term solutions" are needed with any kernel that
doesn't provide the module building support introduced with Linux 2.5,
which will likely be the majority of kernels in use for quite a while,
still.

-- 
christian zander
zander@minion.de
