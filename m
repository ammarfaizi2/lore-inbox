Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267754AbUHPPYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267754AbUHPPYd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 11:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267697AbUHPPUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 11:20:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27360 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267702AbUHPPTK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 11:19:10 -0400
Message-ID: <4120D05D.3020602@pobox.com>
Date: Mon, 16 Aug 2004 11:18:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike_Phillips@URSCorp.com
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Neil Horman <nhorman@redhat.com>, Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: [Patch} to fix oops in olympic token ring driver on media disconnect
References: <OF11E315D2.D4CBAED1-ON85256EF2.0052F29D-85256EF2.0053587E@urscorp.com>
In-Reply-To: <OF11E315D2.D4CBAED1-ON85256EF2.0052F29D-85256EF2.0053587E@urscorp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike_Phillips@URSCorp.com wrote:
>>Well, regardless, Neil's patch is IMO a good first step.
> 
> 
> Neil's patch is to make the annoying regression test failure go away. To 
> be honest I have had *one* user email me that this is a problem and once I 
> gave them the "don't remove the cable on token ring, its not ethernet" 
> talk, they were fine. 


Well I
* disagree the kernel should oops,
* I disagree that olympic should call free_irq in the interrupt handler, and
* I disagree that olympic should do 'dev->stop = NULL' at all, much less 
in the interrupt handler

sorry,

	Jeff


