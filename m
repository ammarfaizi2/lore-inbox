Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129589AbRCGTsd>; Wed, 7 Mar 2001 14:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129734AbRCGTsX>; Wed, 7 Mar 2001 14:48:23 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:40200 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S129589AbRCGTsV>; Wed, 7 Mar 2001 14:48:21 -0500
Message-Id: <200103071948.f27Jm2O29441@aslan.scsiguy.com>
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2-ac13, aic7xxx without any device and oops 
In-Reply-To: Your message of "Wed, 07 Mar 2001 20:37:17 +0700."
             <1671BE33779@vcnet.vc.cvut.cz> 
Date: Wed, 07 Mar 2001 12:48:02 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi Justin,
>  your new driver complains loudly here, because of
>ahc_match_scb is invoked with NULL scb, and it does not like that.
>
>Call trace was:
>   0xc01c9073: ahc_match_scb + 23/191
>   0xc01c945d: ahc_search_qinfifo+ 333/1719 (it is first of two calls to ahc_m
>atch...)
>   0xc01c9ede: ahc_abort_scbs + 102/758

What version of the driver is in ac13?  I may already have a fix
for this.

--
Justin
