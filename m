Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbUC1V0Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 16:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbUC1V0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 16:26:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63457 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262254AbUC1V0S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 16:26:18 -0500
Message-ID: <406742EB.30501@pobox.com>
Date: Sun, 28 Mar 2004 16:26:03 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stefan Smietanowski <stesmi@stesmi.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406616EE.80301@pobox.com> <40667FAB.2090802@stesmi.com> <406734D3.7070501@pobox.com> <406740B9.9040409@stesmi.com>
In-Reply-To: <406740B9.9040409@stesmi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Smietanowski wrote:
> Hi Jeff.
> 
>> SATA ATAPI looks and works just like PATA ATAPI, with one notable 
>> exception:  S/ATAPI will include "asynchronous notification", a 
>> feature that allows you to eliminate the polling of the cdrom driver 
>> that normally occurs.
>>
>> You can use ATAPI on SATA today, using a PATA->SATA bridge.  In fact 
>> that's the only way I can test SATA ATAPI at all, right now.
>>
>> I hope somebody sends me one of these Plextor devices for testing ;-)
> 
> 
> Would that mean that one uses the same (sub)drivers as normal SCSI
> devices do ?
> 
> sd/sg/etc ...

Correct.

	Jeff




