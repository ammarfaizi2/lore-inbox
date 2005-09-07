Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbVIGMD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbVIGMD2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 08:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbVIGMD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 08:03:28 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:2221 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932132AbVIGMD1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 08:03:27 -0400
Message-ID: <431ED6DC.9040503@lifl.fr>
Date: Wed, 07 Sep 2005 14:02:36 +0200
From: Eric Piel <Eric.Piel@lifl.fr>
User-Agent: Mozilla Thunderbird 1.0.6-5mdk (X11/20050322)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: =?UTF-8?B?TcOgcml1cyBNb250w7Nu?= <Marius.Monton@uab.es>,
       linux-kernel@vger.kernel.org, mulix@mulix.org
Subject: Re: 'virtual HW' into kernel (SystemC)
References: <431EC16B.2040604@uab.es> <431ED1B9.7040407@pobox.com>
In-Reply-To: <431ED1B9.7040407@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

09/07/2005 01:40 PM, Jeff Garzik wrote/a écrit:
> Màrius Montón wrote:
> 
:
>> At this point, we plan to develop a pci device driver to act as a bridge
>> between kernel PCI subsystem and SystemC simulator (in user space).
> 
> 
> No need for a set of tools.  As long as your SystemC simulator simulates 
> an entire platform -- CPU, DRAM, etc. -- then you can boot Linux on the 
> simulated platform.
> 
> If you can boot Linux on the simulated platform, then you can easily 
> develop a Linux driver long before real HW is available.

No, this approach is not feasible because it would be require to 
describe the entire computer in SystemC: it's extremly complex to do and 
the simulation will be very slow.

 From what I understand Màrius tries to only simulate one component 
(like a PCI card). As suggested Muli, a plugin to something like quemu 
sounds like a good idea?

Eric

