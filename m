Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbULTIeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbULTIeq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 03:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbULTIdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 03:33:54 -0500
Received: from r3az252.chello.upc.cz ([213.220.243.252]:11137 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S261472AbULTIdO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 03:33:14 -0500
Message-ID: <41C68E46.4060200@ribosome.natur.cuni.cz>
Date: Mon, 20 Dec 2004 09:33:10 +0100
From: =?ISO-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20041217
X-Accept-Language: cs, en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: OOPS in 2.4.29-pre2
References: <41C43165.8010700@ribosome.natur.cuni.cz> <41C4DF86.1090209@pobox.com>
In-Reply-To: <41C4DF86.1090209@pobox.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Martin MOKREJ© wrote:
> 
>> Hi,
>>  I'm testing 2.4.29-pre2 kernelon my ASUS L3800C laptop.
>> I have already managed to get several, this is one of them.
>> Please Cc: me in replies. Thanks.
>>
>>
>> Unable to handle kernel paging request at virtual address 5a5a5a5a
>> 5a5a5a5a
> 
> 
> That looks like an artifact of "poisoning" (debugging) code.

Yes, I do use:

> What options under the debug menu do you have enabled?

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_FRAME_POINTER=y
CONFIG_LOG_BUF_SHIFT=0
