Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263725AbUHJJV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263725AbUHJJV3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 05:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUHJJV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 05:21:29 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:3078 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S263725AbUHJJUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 05:20:44 -0400
Message-ID: <41189443.3040504@hist.no>
Date: Tue, 10 Aug 2004 11:24:19 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
CC: alan@lxorguk.ukuu.org.uk, axboe@suse.de, linux-kernel@vger.kernel.org,
       vonbrand@inf.utfsm.cl
Subject: Re: Linux Kernel bug report (includes fix)
References: <200408091420.i79EKBEu010574@burner.fokus.fraunhofer.de>
In-Reply-To: <200408091420.i79EKBEu010574@burner.fokus.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:

>
>>Linux kernel include files are not meant to be used by user
>>applications. He's perfectly correct. Glibc has its own exported set.
>>This is intentional to seperate internals from user space.
>>    
>>
>
>You should know that GLIBc is unrelated to the Linux kernel interfaces we are 
>talking about. Start using serious arguments please.
>  
>
The kernel headers are _still_ not meant to be used by userspace,
so don't try that.  If you don't want to use glibc headers - you get to 
write
your own headers.  You can extract info from the kernel headers, but they
cannot be used directly from userspace programs.  They are not designed to
be used that way.

Helge Hafting
