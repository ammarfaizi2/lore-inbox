Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbUKOPp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbUKOPp6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 10:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbUKOPp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 10:45:58 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:31458 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261624AbUKOPpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 10:45:51 -0500
Subject: Re: [2.6 patch] SCSI t128.c: remove an unused function
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041115023859.GE2249@stusta.de>
References: <20041115023859.GE2249@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100529621.27202.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 15 Nov 2004 14:40:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-11-15 at 02:38, Adrian Bunk wrote:
> The patch below removes the unused function t128_setup.
> 
> Please review whether it's correct.

Its wrong. The fix is to make the setup function get called, IFF you can
find anyone with a t128 any more

