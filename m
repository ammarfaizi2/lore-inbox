Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266508AbUIANVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266508AbUIANVM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 09:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266507AbUIANVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 09:21:11 -0400
Received: from the-village.bc.nu ([81.2.110.252]:11659 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266508AbUIANU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 09:20:28 -0400
Subject: Re: MMC block major dev
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4134CDF0.7070600@drzeus.cx>
References: <4134CDF0.7070600@drzeus.cx>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094041098.2476.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 01 Sep 2004 13:18:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-31 at 20:13, Pierre Ossman wrote:
> Some debug statements revealed that the driver ended up on major number 
> 254. I'm not familiar with how kernel memory is initialized but using an 
> uninitialized variable should result in random numbers. It seems to get 
> 254 each time though. Can I count on this? (i.e. can I safely create 
> device node files with this major).

No.

