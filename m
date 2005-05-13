Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262558AbVEMVXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbVEMVXD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 17:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbVEMVXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 17:23:02 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:8139 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262553AbVEMVW1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 17:22:27 -0400
Subject: Re: [rfc/patch] libata -- port configurable delays
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: jgarzik@pobox.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050513185850.GA5777@kvack.org>
References: <20050513185850.GA5777@kvack.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1116019231.26693.499.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 13 May 2005 22:20:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-05-13 at 19:58, Benjamin LaHaise wrote:
> is available at http://www.kvack.org/~bcrl/simple-aio-min_nr.c).  
> Before this patch __delay() is the number one entry in oprofile 
> results for this workload.  Does this look like a reasonable approach 
> for chipsets that aren't completely braindead?  Cheers,

If your chipset implements the 400nS lockout in hardware it certainly
seems to make sense. Nice to know someone has put it in hardware

