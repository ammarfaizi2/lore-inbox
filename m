Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267277AbTCEP4l>; Wed, 5 Mar 2003 10:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267278AbTCEP4k>; Wed, 5 Mar 2003 10:56:40 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:26005 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S267277AbTCEP4N>; Wed, 5 Mar 2003 10:56:13 -0500
Message-Id: <200303051605.h25G5MGi006734@locutus.cmf.nrl.navy.mil>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] make atm (and clip) modular + try_module_get() 
In-reply-to: Your message of "Wed, 05 Mar 2003 09:58:40 CST."
             <Pine.LNX.4.44.0303050952010.31461-100000@chaos.physics.uiowa.edu> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Wed, 05 Mar 2003 11:05:22 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0303050952010.31461-100000@chaos.physics.uiowa.edu>,K
ai Germaschewski writes:
>atm-$(subst m,y,$(CONFIG_ATM_CLIP))	+= ipcommon.o
>atm-$(subst m,y,$(CONFIG_NET_SCH_ATM))	+= ipcommon.o

i cant do this because if both CONFIG_ATM_CLIP and CONFIG_NET_SCH_ATM
are configured, ipcommon.o will be in the link list twice twice.
