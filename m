Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267001AbTAZVhP>; Sun, 26 Jan 2003 16:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267003AbTAZVhP>; Sun, 26 Jan 2003 16:37:15 -0500
Received: from [213.86.99.237] ([213.86.99.237]:50397 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S267001AbTAZVhO>; Sun, 26 Jan 2003 16:37:14 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20030126220842.GB394@kugai> 
References: <20030126220842.GB394@kugai>  <20030123193540.GD13137@ca-server1.us.oracle.com> <Pine.LNX.4.44.0301261054250.15538-100000@chaos.physics.uiowa.edu> 
To: Christian Zander <zander@minion.de>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 26 Jan 2003 21:40:22 +0000
Message-ID: <28922.1043617222@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


zander@minion.de said:
> External projects may not want to use the build flags unchanged, they
> may have good reasons for using their own. 

That's what EXTRA_CFLAGS and CFLAGS_someobject.o are for.

> It seems sensible to make the kernel build system available to those 
> who wish to use it, but it should be optional rather than mandatory. 
> In this specific case, there is no technical reason to require the use
> of kbuild.

The use of the kernel build process to build kernel modules is not 
_mandatory_, it's just that it's the only sane option.

You are, of course, welcome to hack up your own broken and short-term
solutions which happen to work this week for some platforms. But don't come
crying to us when (not if) they stop working.

The use of vermagic.c doesn't stop you from making your own build system; 
you can have your own vermagic.c to make your hacks work this week.

--
dwmw2


