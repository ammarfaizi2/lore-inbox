Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbULQQxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbULQQxR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 11:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbULQQxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 11:53:16 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:25224 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261889AbULQQxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 11:53:13 -0500
Message-ID: <41C30ED6.5010201@colorfullife.com>
Date: Fri, 17 Dec 2004 17:52:38 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] [RFC] fork historic module
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi wrote:

>> +/* IOCTL numbers */
>> +/* If you add a new IOCTL number don't forget to update FH_MAXNR */
>> +#define FH_MAGIC	0x35
>> +#define FH_REGISTER	_IO(FH_MAGIC,0)
>> +#define FH_UNREGISTER	_IO(FH_MAGIC,1)
>
>Is this really unique? 32bit emulation currently needs unique ioctl numbers.
>  
>
Are there plans to fix that? Perhaps move the emulation callback into 
struct file?

--
    Manfred

