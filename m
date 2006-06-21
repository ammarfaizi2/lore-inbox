Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbWFUEDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWFUEDL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 00:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751978AbWFUEDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 00:03:11 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:55940 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1750843AbWFUEDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 00:03:10 -0400
Message-ID: <4498C4E1.40505@myri.com>
Date: Wed, 21 Jun 2006 00:02:41 -0400
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>, ak@suse.de,
       davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-git build breakage
References: <4497A871.8000303@garzik.org> <20060620011738.d72147a8.akpm@osdl.org> <Pine.LNX.4.64.0606201957420.5498@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606201957420.5498@g5.osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Tue, 20 Jun 2006, Andrew Morton wrote:
>
>   
>> On Tue, 20 Jun 2006 03:49:05 -0400
>> Jeff Garzik <jeff@garzik.org> wrote:
>>
>>     
>>> On the latest 'git pull', on x86-64 SMP 'make allmodconfig', I get the 
>>> following build breakage:
>>>
>>> 1) myri10ge: needs iowrite64_copy from -mm
>>>       
>> Patch has been sent.
>>     
>
> Actually, not as far as I can tell.
>
> I got "s390: add __raw_writeq required by __iowrite64_copy" which was 
> apparently the requisite patch for the actual iowrite64_patch.
>
> But no iowrite64 patch itself. Andrew?
>   

myri10ge actually also needs pci-add-pci_cap_id_vndr.patch (Greg-KH will
send it soon).

Brice

