Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264300AbRFXRly>; Sun, 24 Jun 2001 13:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264303AbRFXRlo>; Sun, 24 Jun 2001 13:41:44 -0400
Received: from mail12.speakeasy.net ([216.254.0.212]:16397 "HELO
	mail12.speakeasy.net") by vger.kernel.org with SMTP
	id <S264300AbRFXRle>; Sun, 24 Jun 2001 13:41:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: linux-kernel@vger.kernel.org
Subject: anyway to stop dma timeouts in 2.2.19?
Date: Sun, 24 Jun 2001 13:41:28 -0400
X-Mailer: KMail [version 1.2.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010624174143Z264300-17720+7238@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I never got dma timeouts running 2.2.19 before installing my promise ata66 
card and CDRW.  Now i get them whenever disk usage is up and what ends up 
happening is none of my drives running in dma mode.  Is this some effect of 
enabling the UDMA features of the promise card ?  If i compiled the kernel 
without these UDMA features on the promise card, would it fix the problem?  I 
have 5 drives now, 3 are UDMA4 drives and 1 (secondary slave) is a cdrom 
using DMA.  I can move this to the secondary channel of the promise card if 
that will help.  Is there any way to predict if you're going to have trouble 
with DMA's?  
