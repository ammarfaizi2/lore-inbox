Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWDDSIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWDDSIH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 14:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWDDSIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 14:08:07 -0400
Received: from 64-44-36-66.user.uswo.net ([64.44.36.66]:24377 "EHLO
	mail.int.automatika.com") by vger.kernel.org with ESMTP
	id S1750783AbWDDSIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 14:08:06 -0400
Message-ID: <4432B5D8.5050003@automatika.com>
Date: Tue, 04 Apr 2006 14:07:20 -0400
From: Kartik Babu <kbabu@automatika.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: dma_alloc_coherent
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I'm trying to replace consistent_alloc in a driver that was written 
for the 2.4 kernel with dma_alloc_coherent. My question is that I do not 
use a struct device * pointer at all. Browsing through the source for 
the 2.6.12
on ARM XScale PXA255, I see that this argument may be NULL.

 Still, I'd like to know if passing NULL has any side effects. If so, 
what are they?

 I do however have a cdev structure taht I use for device registration, 
but I do not see how that would help.

Thanks
Kartik
