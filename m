Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262319AbVBQSp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbVBQSp3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 13:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbVBQSp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 13:45:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60843 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262319AbVBQSpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 13:45:21 -0500
Message-ID: <4214E633.7010705@pobox.com>
Date: Thu, 17 Feb 2005 13:45:07 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Witold Krecicki <adasi@kernel.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: sil_blacklist - are all those entries necessary?
References: <200502151706.04846.adasi@kernel.pl> <200502170143.00817.adasi@kernel.pl> <4213EC86.9020108@pobox.com> <200502170205.48200.adasi@kernel.pl>
In-Reply-To: <200502170205.48200.adasi@kernel.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Witold Krecicki wrote:
> Dnia czwartek 17 luty 2005 01:59, napisa³e¶:
> 
>>>is there ANY way to test if this hack is necessary for specific model of
>>>a disk?
>>
>>You need a bus analyzer, and need to test different sizes of FIS's.  If
>>all possible sizes (2048 combinations) work on your device, the
>>blacklist entry is not needed.
> 
> is there any software bus analyzer? And if so, is there  
> Testing-different-sizes-of-FIS's-for-dummies anywhere ?

You could modify a few drivers to receive an "unknown FIS", or receive 
all FIS's into a DMA-able area that the system could then read.  So it's 
doable.  I just don't have time to teach all of SATA and ATA to you :) 
See http://linux.yyz.us/sata/devel.html

	Jeff
