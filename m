Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267215AbUBMVD6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 16:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267214AbUBMVD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 16:03:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41178 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267216AbUBMVDd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 16:03:33 -0500
Message-ID: <402D3B97.70005@pobox.com>
Date: Fri, 13 Feb 2004 16:03:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Schlemmer <azarah@nosferatu.za.org>
CC: akpm@osdl.org, torvalds@osdl.org,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] 2.6.x libata update
References: <20040213184316.GA28871@gtf.org> <1076700491.22542.38.camel@nosferatu.lan>
In-Reply-To: <1076700491.22542.38.camel@nosferatu.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schlemmer wrote:
> On Fri, 2004-02-13 at 20:43, Jeff Garzik wrote:
> 
> Hi
> 
> 
>><jgarzik@redhat.com> (04/02/13 1.1634)
>>   [libata] catch, and ack, spurious DMA interrupts
>>   
>>   Hardware issue on Intel ICH5 requires an additional ack sequence
>>   over and above the normal IDE DMA interrupt ack requirements.  Issue
>>   described in post to freebsd list:
>>   http://www.mail-archive.com/freebsd-stable@freebsd.org/msg58421.html
>>   
>>   Since the bug workaround only requires a single additional PIO or
>>   MMIO read in the interrupt handler, it is applied to all chipsets
>>   using the standard libata interrupt handler.
>>   
>>   Credit for research the issue, creating the patch, and testing the
>>   patch all go to Jon Burgess.
>>
> 
> 
> Did you miss the mail I sent about this locking my box in under
> 20-30 mins?  It still looks the same as the previous one ....


Yes, I did.  Can you test 2.6.3-rc2 + this patch?

	Jeff



