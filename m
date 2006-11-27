Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758625AbWK0X4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758625AbWK0X4k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 18:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758627AbWK0X4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 18:56:39 -0500
Received: from imladris.surriel.com ([66.92.77.98]:20628 "EHLO
	imladris.surriel.com") by vger.kernel.org with ESMTP
	id S1758625AbWK0X4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 18:56:39 -0500
Message-ID: <456B7B06.70709@surriel.com>
Date: Mon, 27 Nov 2006 18:55:50 -0500
From: Rik van Riel <riel@surriel.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Apan Qasem <qasem@cs.rice.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Page coloring in linux
References: <F17CDCEE-BD2F-458D-93A9-A7D1422598C9@cs.rice.edu>
In-Reply-To: <F17CDCEE-BD2F-458D-93A9-A7D1422598C9@cs.rice.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apan Qasem wrote:
> Does anyone know where I can find documentation on the page coloring 
> algorithm?  I just need to find out the the basic heuristics used in 
> coloring the pages.
> 
> Also, does the kernel source include the page coloring code or do I need 
> to patch the kernel?

The Linux kernel does not do page coloring.

One reason for this is that the vast majority of processors
has 4-way, 8-way or higher cache associativity, meaning that
the gains that could be had from coloring are a lot smaller
than they used to be.

Cache coloring is not free, either.

-- 
Politics is the struggle between those who want to make their country
the best in the world, and those who believe it already is.  Each group
calls the other unpatriotic.
