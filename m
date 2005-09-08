Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965088AbVIHXzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965088AbVIHXzH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 19:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965086AbVIHXzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 19:55:06 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:63133 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S965084AbVIHXzF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 19:55:05 -0400
Date: Fri, 9 Sep 2005 01:49:33 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Miroslaw Mieszczak <mieszcz@zabrze.zigzag.pl>
Cc: linux-kernel@vger.kernel.org, Valdis.Kletnieks@vt.edu, jgarzik@pobox.com
Subject: Re: Patch for link detection for R8169
Message-ID: <20050908234933.GA3747@electric-eye.fr.zoreil.com>
References: <431DA887.2010008@zabrze.zigzag.pl> <20050906194602.GA20862@electric-eye.fr.zoreil.com> <200509062002.j86K28R8019604@turing-police.cc.vt.edu> <20050906204221.GB20862@electric-eye.fr.zoreil.com> <431EFD0E.9030409@zabrze.zigzag.pl> <20050907181721.GA7765@electric-eye.fr.zoreil.com> <43207052.3030403@zabrze.zigzag.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43207052.3030403@zabrze.zigzag.pl>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miroslaw Mieszczak <mieszcz@zabrze.zigzag.pl> :
> Francois Romieu napisał(a):
> 
> >You can silence this message in 2.6.13 by using the 'msglvl'
> >option of the ethtool command.
>
> It would be disabled only this message, or all warning messages from the 
> net driver?

One issues 'ethtool msglvl xyz' where xyz is the bitwise OR of the messages
which should be kept. The r8169 driver allows the same mask via the "debug"
option of the module.

The meaning of the bitflags is driver dependent. A summary of the messages
for the r8169 driver is available at:
http://www.zoreil.com/~romieu/r8169/doc/msglvl.txt

--
Ueimor
