Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbVLETL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbVLETL1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 14:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbVLETL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 14:11:27 -0500
Received: from [216.240.47.197] ([216.240.47.197]:17873 "EHLO
	delight.idiom.com") by vger.kernel.org with ESMTP id S932513AbVLETL0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 14:11:26 -0500
Message-ID: <439490BB.9050600@obviously.com>
Date: Mon, 05 Dec 2005 11:10:51 -0800
From: Bryce Nesbitt <bryce1@obviously.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] Fix ECC error counting for AMD76x chipset, char/ecc.c
 driver
References: <4394864D.3000704@obviously.com> <20051205184656.GH12664@redhat.com>
In-Reply-To: <20051205184656.GH12664@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> drivers/char/ecc.c only lives in various vendor kernels.
>
> you may want to check if your patch is relevant to the edac
> code present in -mm though.
Thanks.

The EDAC code appears to do this correctly, though it is much  heavier
code (involving multiple functions, and pci and irq locking that appears
correct, but unnecessarily pedantic).
