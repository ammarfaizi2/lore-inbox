Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbVIGSTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbVIGSTJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 14:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbVIGSTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 14:19:09 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:36290 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S932187AbVIGSTH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 14:19:07 -0400
Date: Wed, 7 Sep 2005 20:17:21 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Miroslaw Mieszczak <mieszcz@zabrze.zigzag.pl>
Cc: Valdis.Kletnieks@vt.edu, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: Patch for link detection for R8169
Message-ID: <20050907181721.GA7765@electric-eye.fr.zoreil.com>
References: <431DA887.2010008@zabrze.zigzag.pl> <20050906194602.GA20862@electric-eye.fr.zoreil.com> <200509062002.j86K28R8019604@turing-police.cc.vt.edu> <20050906204221.GB20862@electric-eye.fr.zoreil.com> <431EFD0E.9030409@zabrze.zigzag.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431EFD0E.9030409@zabrze.zigzag.pl>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miroslaw Mieszczak <mieszcz@zabrze.zigzag.pl> :
[...]
> The main problem with this driver is, that if I do like this, then every 
> 10 seconds I receive new message from the network card in kernel log.
> There is following message:
> 
> Sep  4 16:31:43 laptop_mirka eth0: PHY reset until link up
> Sep  4 16:31:53 laptop_mirka eth0: PHY reset until link up

You can silence this message in 2.6.13 by using the 'msglvl'
option of the ethtool command.

> Do you think, that this is correct way t do the things?

You would not believe how arrogant I can be :o)

More seriously, does there remain any issue for you wrt the
usability of the r8169 driver ?

--
Ueimor
