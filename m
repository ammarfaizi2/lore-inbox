Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbVI1UO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbVI1UO0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 16:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbVI1UO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 16:14:26 -0400
Received: from hulk.vianw.pt ([195.22.31.43]:63118 "EHLO hulk.vianw.pt")
	by vger.kernel.org with ESMTP id S1750765AbVI1UOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 16:14:25 -0400
Message-ID: <433AF98E.4020504@esoterica.pt>
Date: Wed, 28 Sep 2005 21:14:06 +0100
From: Paulo da Silva <psdasilva@esoterica.pt>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Strange behaviour with SATA disks. Light always ON
References: <43374DDB.6090708@esoterica.pt> <20050928064612.GL2811@suse.de>
In-Reply-To: <20050928064612.GL2811@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>On Mon, Sep 26 2005, Paulo da Silva wrote:
>  
>
>>Hi!
>>I don't know if this is the right place to ask
>>about this, or even if this is a problem at all.
>>
>>Anyway I didn't find relevant information on
>>this ...
>>
>>I have just bought a new PC with two SATA drives.
>>I had no problems to have them working,
>>apparently fine except for one thing:
>>After reading the kernel, the driver access light (led?)
>>is always on!
>>Is this normal? Why?
>>    
>>
>
>It's a bug in the ahci driver in the kernel, if you upgrade to a newer
>kernel it is fixed there. The changeset of interest is:
>
>http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=c0b34ad2956036cdba87792d6c46d8f491539df1;hp=9309049544935f804b745aa4dea043fb39b2bf2a
>
>  
>
I patched it by hand (just deleting 2 lines).
I works fine now!!!
I searched for a solution using "access light "
keywords, but should have used "LED" instead :-(

Thank you.

