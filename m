Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272086AbRHWBOA>; Wed, 22 Aug 2001 21:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272106AbRHWBNu>; Wed, 22 Aug 2001 21:13:50 -0400
Received: from mail12.speakeasy.net ([216.254.0.212]:43785 "EHLO
	mail12.speakeasy.net") by vger.kernel.org with ESMTP
	id <S272086AbRHWBNk>; Wed, 22 Aug 2001 21:13:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: linux-kernel@vger.kernel.org
Subject: DMA blacklist for buggy hardware?
Date: Wed, 22 Aug 2001 21:13:55 -0400
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010823011342Z272086-760+4794@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm aware that there is a DMA blacklist for certain hardware that cant get 
along with standard DMA drivers in linux and indeed certain hardware that 
doesn't get along in my OS's when using dma.  One such drive is the Kenwood 
TrueX cdroms.  There are lots of problems documented with these drives and 
dma usage.  I have one and i've had problems when using it in DMA mode for 
years.  I suggest putting them on the blacklist so enabling DMA to these 
drives is not possible to make sure problems with system use aren't due to 
this.  Enabling DMA on this line of drives can cause infinite atapi reset 
loops on some kernels, dma timeouts that can bring a system to a halt until 
it eventually resets and data corruption. The latest kernels seem to behave 
much better when errors result from enabling dma on this drive but in the 
past that hasn't been the case and there is still the reset which effects the 
other drive on the controller as well.    Thanks.   
