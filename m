Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262862AbSJAWVo>; Tue, 1 Oct 2002 18:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262854AbSJAWUN>; Tue, 1 Oct 2002 18:20:13 -0400
Received: from [195.39.17.254] ([195.39.17.254]:11268 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262862AbSJAWSI>;
	Tue, 1 Oct 2002 18:18:08 -0400
Date: Tue, 1 Oct 2002 00:43:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Daniel E. F. Stekloff" <dsteklof@us.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       "ipslinux (Keith Mitchell)" <ipslinux@us.ibm.com>,
       Linus Torvalds <torvalds@home.transmeta.com>,
       Hien Nguyen <hien@us.ibm.com>, James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
Subject: Re: [evlog-dev] alternate event logging proposal
Message-ID: <20021001004331.A10732@elf.ucw.cz>
References: <20020924073051.363D92C1A7@lists.samba.org> <3D90C183.5020806@pobox.com> <200209241354.38013.dsteklof@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209241354.38013.dsteklof@us.ibm.com>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> - Drivers should log initialization and uninitialization information for both 
> drivers and devices. Knowning when a driver is loaded or unloaded is useful 
> information. 

[snip]

> - Beware of log pollution - log only relevant information. Avoid frequently 
> recurring messages. 

You should not report *driver* initialization but only hardware one,
or you are going to overrun dmesg very fast (log pollution).

Driver version is useless -- you already know what kernel you are
booting -- right?
								Pavel
-- 
When do you have heart between your knees?
