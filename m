Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbVIGMHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbVIGMHY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 08:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVIGMHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 08:07:24 -0400
Received: from mail.dvmed.net ([216.237.124.58]:18157 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751204AbVIGMHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 08:07:24 -0400
Message-ID: <431ED7F2.5030200@pobox.com>
Date: Wed, 07 Sep 2005 08:07:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Piel <Eric.Piel@lifl.fr>
CC: =?UTF-8?B?TcOgcml1cyBNb250w7Nu?= <Marius.Monton@uab.es>,
       linux-kernel@vger.kernel.org, mulix@mulix.org
Subject: Re: 'virtual HW' into kernel (SystemC)
References: <431EC16B.2040604@uab.es> <431ED1B9.7040407@pobox.com> <431ED6DC.9040503@lifl.fr>
In-Reply-To: <431ED6DC.9040503@lifl.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Piel wrote:
> 09/07/2005 01:40 PM, Jeff Garzik wrote/a écrit:
>> No need for a set of tools.  As long as your SystemC simulator 
>> simulates an entire platform -- CPU, DRAM, etc. -- then you can boot 
>> Linux on the simulated platform.
>>
>> If you can boot Linux on the simulated platform, then you can easily 
>> develop a Linux driver long before real HW is available.
> 
> 
> No, this approach is not feasible because it would be require to 
> describe the entire computer in SystemC:

Correct.


> it's extremly complex to do

Not if you can reuse pre-existing parts from http://www.opencores.org/ 
and similar places.


> the simulation will be very slow.

Depends on your simulator ;-)


>  From what I understand Màrius tries to only simulate one component 
> (like a PCI card). As suggested Muli, a plugin to something like quemu 
> sounds like a good idea?

A plugin to qemu or Bochs should work, in theory.  In practice, neither 
are great for PCI MMIO or PCI DMA.

	Jeff


