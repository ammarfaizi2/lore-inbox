Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318963AbSHMHvs>; Tue, 13 Aug 2002 03:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318964AbSHMHvr>; Tue, 13 Aug 2002 03:51:47 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:16904 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S318963AbSHMHvr>; Tue, 13 Aug 2002 03:51:47 -0400
Date: Tue, 13 Aug 2002 09:54:42 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Peter Samuelson <peter@cadcamlab.org>
cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Greg Banks <gnb@alphalink.com.au>, <linux-kernel@vger.kernel.org>,
       <kbuild-devel@lists.sourceforge.net>
Subject: Re: [patch] config language dep_* enhancements
In-Reply-To: <20020813000300.GE761@cadcamlab.org>
Message-ID: <Pine.LNX.4.44.0208130951150.28515-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 12 Aug 2002, Peter Samuelson wrote:

> tristate DRV
> dep_mbool DRV_OLD DRV
>
> dep_mbool COMMON_OPT DRV
> dep_mbool OLD_OPT1 DRV_OLD
> dep_mbool OLD_OPT2 DRV_OLD
> dep_mbool NEW_OPT1 DRV !DRV_OLD
> dep_mbool NEW_OPT2 DRV !DRV_OLD

This way you can't compile old and new driver as module.

bye, Roman

