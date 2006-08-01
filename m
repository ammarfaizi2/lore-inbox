Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbWHAHGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbWHAHGk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 03:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWHAHGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 03:06:40 -0400
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:27358
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S932518AbWHAHGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 03:06:40 -0400
Message-ID: <44CEFD78.6050308@ed-soft.at>
Date: Tue, 01 Aug 2006 09:06:32 +0200
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 2/3] add-force-of-use-mmconfig.patch
References: <44CDBF1E.2010001@ed-soft.at>	<20060731221841.9195556c.akpm@osdl.org>	<44CEE5F7.6050402@ed-soft.at> <20060731224608.15b13b59.akpm@osdl.org>
In-Reply-To: <20060731224608.15b13b59.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton schrieb:
> On Tue, 01 Aug 2006 07:26:15 +0200
> Edgar Hucek <hostmaster@ed-soft.at> wrote:
> 
>> Andrew Morton schrieb:
>>> On Mon, 31 Jul 2006 10:28:14 +0200
>>> Edgar Hucek <hostmaster@ed-soft.at> wrote:
>>>
>>>> This Patch add force for mmconfig. On Intel Macs the efi firmaware gives
>>>> a different memory map then ACPI_MCFG provides. This makes the check wether
>>>> to use mmconfig or not fail.
>>> Sorry, you cannot do this.  I already merged this patch into -mm, and
>>> followed that up with two bugfix patches, both of which you were copied on.
>>>
>>> Now you're sending out the original patch, without the bugfixes which
>>> Adrian and I prepared.
>>>
>>> If you think these patches should be merged into 2.6.18 at this late a
>>> stage, please give reasons and if they're agreeable I can send it all to
>>> Linus.  But sending out known-buggy stuff which has already been fixed
>>> doesn't help anyone.
>>>
>>> Also, please don't use filenames as patch descriptions.  See section 2 of
>>> http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt.
>>>
>>> Thanks.
>>>
>> I see only one bugfix patch in your patches ( add-force-of-use-mmconfig-fix.patch )
>> which is now included in this patch.
>>
> 
> I presently have
> 
> add-force-of-use-mmconfig.patch
> add-force-of-use-mmconfig-fix.patch
> add-force-of-use-mmconfig-fix-2.patch
> 
> and
> 
> add-efi-e820-memory-mapping-on-x86.patch
> add-efi-e820-memory-mapping-on-x86-tidy.patch
> add-efi-e820-memory-mapping-on-x86-fix.patch
> add-efi-e820-memory-mapping-on-x86-fix-2.patch
> 
> all of which you should have been cc'ed on.
> 
> Anyway, unless there's a rush on this work, please check that everything
> looks OK in -mm as we head into 2.6.19-rc1.
> 

Mea culpa. Looked at the wrong place. I checked the patches in mm and they look ok.

cu

Edgar Hucek

