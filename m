Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264119AbTLAWBH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 17:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264123AbTLAWBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 17:01:07 -0500
Received: from mrout1.yahoo.com ([216.145.54.171]:32269 "EHLO mrout1.yahoo.com")
	by vger.kernel.org with ESMTP id S264119AbTLAWBC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 17:01:02 -0500
Message-ID: <3FCBB9F1.2080300@bigfoot.com>
Date: Mon, 01 Dec 2003 14:00:17 -0800
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i386; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: libata in 2.4.24?
References: <Pine.LNX.4.44.0312010836130.13692-100000@logos.cnet>	<3FCB8312.3050703@rackable.com> <87fzg4ckej.fsf@stark.dyndns.tv> <3FCBB15F.7050505@rackable.com>
In-Reply-To: <3FCBB15F.7050505@rackable.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Flory wrote:
> Greg Stark wrote:
> 
>> Samuel Flory <sflory@rackable.com> writes:
>>
>>
>>>   It's getting harder to find a newly released motherboard without 
>>> onboard
>>> sata.  Not having  libata support means that anyone running 2.4 
>>> unpatched will
>>> be unable to use such systems.
>>
>>
>>
>> My motherboard has a SATA controller and I'm using it in non-legacy 
>> mode with
>> 2.4.23. What is this libata thing I'm supposed to be needing?
>>
> 
>   What chipset are you using?  Assumming that hda is your sata drive. 
> What are the results of the following "hdarm -t /dev/hda" "hdparm -dvi 
> /dev/hda"   The ICH5 chipset is the only chipset I've found that works 
> well without libata.

   not for drives >133GB (I have intel D865PERL mb and 250GB matrox, it 
doesn't work without SCSI_ATA (at all), it cannot read/write above 133GB 
without libata patches)

	erik

