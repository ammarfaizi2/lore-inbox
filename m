Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbUL2PKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbUL2PKL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 10:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbUL2PKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 10:10:11 -0500
Received: from mail3.euroweb.net.mt ([217.145.4.38]:62928 "EHLO
	mail3.euroweb.net.mt") by vger.kernel.org with ESMTP
	id S261353AbUL2PKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 10:10:05 -0500
Message-ID: <41D2C8CD.8070001@euroweb.net.mt>
Date: Wed, 29 Dec 2004 16:10:05 +0100
From: "Josef E. Galea" <josefeg@euroweb.net.mt>
User-Agent: Mozilla Thunderbird 1.0RC1 (Windows/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Coywolf Qi Hunt <coywolf@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Memory management in Linux
References: <41D2ABA8.2080906@euroweb.net.mt> <2cd57c900412290606f356334@mail.gmail.com>
In-Reply-To: <2cd57c900412290606f356334@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:

>On Wed, 29 Dec 2004 14:05:44 +0100, Josef E. Galea
><josefeg@euroweb.net.mt> wrote:
>  
>
>>Hi all,
>>
>>Does the linux kernel allow a process to handle its own memory pages
>>instead of using the kernel's virtual memory manager?
>>
>>Thanks & Happy Holidays
>>Josef
>>    
>>
>
>
>That's quite related to ``adaptive page replacement''. Linux doesn't
>support that at present imho.
>
>--cqh
>
>
>  
>
Ok I may have got the name wrong :). What I am trying to do is to 
implement a package on linux similiar to the TreadMarks by Alan Cox et 
al. (ref. http://citeseer.ist.psu.edu/amza96treadmarks.html) that runs 
at kernel level instead of user level. Right now I think that inorder to 
achieve what I want to do, I have to change the code of the linux 
virtual memory manager. This is ok for academic purposes (which is my 
aim) however it severly reduces portability (it is much easier to just 
load a kernel module than to patch and recompile the kernel).

Thanks
Josef
