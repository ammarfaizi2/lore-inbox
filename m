Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbVHHFUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbVHHFUF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 01:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbVHHFUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 01:20:05 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:12554 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750727AbVHHFUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 01:20:05 -0400
Message-ID: <42F6EB73.3030104@vmware.com>
Date: Sun, 07 Aug 2005 22:19:47 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Fawad Lateef <fawadlateef@gmail.com>
Cc: linux-kernel@vger.kernel.org, nhorman@redhat.com
Subject: Re: Highmemory Problem with RHEL3 .... 2.4.21-5.ELsmp
References: <1e62d137050807205047daf9e0@mail.gmail.com>
In-Reply-To: <1e62d137050807205047daf9e0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Aug 2005 05:19:04.0843 (UTC) FILETIME=[B1D0F5B0:01C59BD8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fawad Lateef wrote:

>Hello,
>
>I m facing a problem in RHEL3 (2.4.21-5.ELsmp) kernel while using
>kmap_atomic on the pages reserved at the boot time !!!!
>
>At the boot time I reserved pages above 2GB for later use by my module
>..... And when I was using those reserved pages through kmap_atomic
>system hangs; although kmap_atomic successfully returns me the virtual
>address but when I use that virtual address like in memcpy the system
>hangs .....
>
>I m unable to findout why it is happening in RHEL3 kernel !!!! Plz
>help me in this regard ....
>  
>

IIRC 2.4.21 has some highmem bugs that have since been fixed.  But, it 
sounds like you might be doing something quite unusual.  Code would 
definitely give people a better idea of what might be wrong.  You should 
definitely consider moving to 2.6 to get a better response.

Zach
