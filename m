Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316342AbSHOBMY>; Wed, 14 Aug 2002 21:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316390AbSHOBMY>; Wed, 14 Aug 2002 21:12:24 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:38901 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S316342AbSHOBMY>; Wed, 14 Aug 2002 21:12:24 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200208150114.g7F1EcY25108@devserv.devel.redhat.com>
Subject: Re: Linux 2.4.20-pre2-ac1
To: eyal@eyal.emu.id.au (Eyal Lebedinsky)
Date: Wed, 14 Aug 2002 21:14:38 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3D5AFDD6.3178894D@eyal.emu.id.au> from "Eyal Lebedinsky" at Aug 15, 2002 11:03:18 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - mm/swap_state.c
> 	Improper use of PAGE_BUG() macro

Yep

> - drivers/isdn/hisax/st5481.h
> 	Usage of '...' in macro, not always compatible with prevailing
> 	versions of gcc. We all know the story though... I just disabled
> 	all the special macros for now

I'll ifdef between the two versions again. I'm not using the old gcc on
any boxes nowdays so I don't catch them
