Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264260AbTLAVYM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 16:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbTLAVYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 16:24:12 -0500
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:24072 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S264260AbTLAVYI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 16:24:08 -0500
Message-ID: <3FCBB15F.7050505@rackable.com>
Date: Mon, 01 Dec 2003 13:23:43 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg Stark <gsstark@mit.edu>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata in 2.4.24?
References: <Pine.LNX.4.44.0312010836130.13692-100000@logos.cnet>	<3FCB8312.3050703@rackable.com> <87fzg4ckej.fsf@stark.dyndns.tv>
In-Reply-To: <87fzg4ckej.fsf@stark.dyndns.tv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Dec 2003 21:24:02.0765 (UTC) FILETIME=[7134BFD0:01C3B851]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Stark wrote:
> Samuel Flory <sflory@rackable.com> writes:
> 
> 
>>   It's getting harder to find a newly released motherboard without onboard
>>sata.  Not having  libata support means that anyone running 2.4 unpatched will
>>be unable to use such systems.
> 
> 
> My motherboard has a SATA controller and I'm using it in non-legacy mode with
> 2.4.23. What is this libata thing I'm supposed to be needing?
> 

   What chipset are you using?  Assumming that hda is your sata drive. 
What are the results of the following "hdarm -t /dev/hda" "hdparm -dvi 
/dev/hda"   The ICH5 chipset is the only chipset I've found that works 
well without libata.


-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>

