Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268251AbUJFGEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268251AbUJFGEn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 02:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268265AbUJFGEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 02:04:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18591 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268251AbUJFGEm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 02:04:42 -0400
Message-ID: <41638AEB.5080703@pobox.com>
Date: Wed, 06 Oct 2004 02:04:27 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: andrea@novell.com, nickpiggin@yahoo.com.au, rml@novell.com,
       roland@topspin.com, linux-kernel@vger.kernel.org
Subject: Re: Preempt? (was Re: Cannot enable DMA on SATA drive (SCSI-libsata,
 VIA SATA))
References: <52is9or78f.fsf_-_@topspin.com>	<4163465F.6070309@pobox.com>	<41634A34.20500@yahoo.com.au>	<41634CF3.5040807@pobox.com>	<1097027575.5062.100.camel@localhost>	<20041006015515.GA28536@havoc.gtf.org>	<41635248.5090903@yahoo.com.au>	<20041006020734.GA29383@havoc.gtf.org>	<20041006031726.GK26820@dualathlon.random>	<4163660A.4010804@pobox.com>	<20041006040323.GL26820@dualathlon.random>	<41636FCF.3060600@pobox.com> <20041005214605.5ec397ab.akpm@osdl.org>
In-Reply-To: <20041005214605.5ec397ab.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>Preempt will always be something I ask people to turn off when reporting 
>> driver bugs; it just adds too much complicated mess for zero gain.
> 
> 
> What driver bugs are apparent with preemption which are not already SMP bugs?

If your implied answer is true, then we wouldn't need 
preempt_{en,dis}able() sprinkled throughout the code so much.

	Jeff


