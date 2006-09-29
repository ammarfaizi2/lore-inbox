Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161091AbWI2QAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161091AbWI2QAv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 12:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161092AbWI2QAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 12:00:51 -0400
Received: from post-25.mail.nl.demon.net ([194.159.73.195]:50418 "EHLO
	post-25.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S1161091AbWI2QAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 12:00:50 -0400
Message-ID: <451D4330.4030108@rebelhomicide.demon.nl>
Date: Fri, 29 Sep 2006 18:00:48 +0200
From: Michiel de Boer <x@rebelhomicide.demon.nl>
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Chipset addition for the VIA Southbridge workaround /
 quirk
References: <fa.a5JNkmioXw5Nk7TL3per32bVULU@ifi.uio.no> <fa.26gtk6nrxcQoI9Era+0RigHE+Ug@ifi.uio.no> <451B2F3A.2090307@shaw.ca>
In-Reply-To: <451B2F3A.2090307@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Andrew Morton wrote:
>>
>> Could you please test 2.6.18-mm1, or simply
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm1/broken-out/via-irq-quirk-behaviour-change.patch 
>>
>
> This is dealing with a different (much older) quirk than that..
>

Yes, that's correct. The code related to the patch i sent in starts 
around line 114 of drivers/pci/quirks.c in 2.6.18:

/*
 *      VIA Apollo KT133 needs PCI latency patch
 *      Made according to a windows driver based patch by George E. Breese
 *      see PCI Latency Adjust on 
http://www.viahardware.com/download/viatweak.shtm
 *      Also see http://www.au-ja.org/review-kt133a-1-en.phtml for
 *      the info on which Mr Breese based his work.
 *
 *      Updated based on further information from the site and also on
 *      information provided by VIA
 */
static void __devinit quirk_vialatency(struct pci_dev *dev)
{

However i will be happy to test anything that would also fix my problem 
and replaces my patch. :)

Regards,  Michiel
