Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267542AbTCEQBY>; Wed, 5 Mar 2003 11:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267545AbTCEQBY>; Wed, 5 Mar 2003 11:01:24 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:20622 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267542AbTCEQBX>; Wed, 5 Mar 2003 11:01:23 -0500
Date: Wed, 5 Mar 2003 10:11:49 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][ATM] make atm (and clip) modular + try_module_get() 
In-Reply-To: <200303051605.h25G5MGi006734@locutus.cmf.nrl.navy.mil>
Message-ID: <Pine.LNX.4.44.0303051010200.31461-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Mar 2003, chas williams wrote:

> In message <Pine.LNX.4.44.0303050952010.31461-100000@chaos.physics.uiowa.edu>,K
> ai Germaschewski writes:
> >atm-$(subst m,y,$(CONFIG_ATM_CLIP))	+= ipcommon.o
> >atm-$(subst m,y,$(CONFIG_NET_SCH_ATM))	+= ipcommon.o
> 
> i cant do this because if both CONFIG_ATM_CLIP and CONFIG_NET_SCH_ATM
> are configured, ipcommon.o will be in the link list twice twice.

The build system actually goes through quite a bit of effort to remove 
those duplicate entries. Try it, if it doesn't work I sure want to know
about it.

--Kai


