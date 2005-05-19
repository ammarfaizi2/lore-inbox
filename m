Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVESUVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVESUVL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 16:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVESUVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 16:21:11 -0400
Received: from hnexfe09.hetnet.nl ([195.121.6.175]:57469 "EHLO
	hnexfe09.hetnet.nl") by vger.kernel.org with ESMTP id S261239AbVESUU4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 16:20:56 -0400
Subject: 2.6.12rc4 (ppc32): Oops: kernel access of bad area, sig: 11 [#1]
From: Michel Roelofs <kimmichel@zonnet.nl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1116534047.3432.11.camel@maan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 19 May 2005 22:20:47 +0200
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 May 2005 20:20:47.0780 (UTC) FILETIME=[3E383E40:01C55CB0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When 2.6.12rc4 boots on my ppc32 (powertower pro 250), I get the
following oops (manually copied):

Oops: kernel access of bad area, sig: 11 [#1]
PREEMPT

<register dump>


TASK=c0981ae0[1] 'swapper'
THREAD c09de000

Last Syscall 120
snd_pmac_dbdma_alloc+0x38/0x104
snd_pmac_new+0x8c/0x450
snd_pmac_probe+0x44/0x320
alsa_card_pmac_init+0x10/0x2c
do_initcalls+0x5c/0xfc
do_basic_setup+0x24/0x34
init+0x30/0xf8
kernel_thread+0x44/0x60



When needed, I'll make a more accurate screen dump.

Michel

