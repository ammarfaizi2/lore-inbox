Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbUL3EcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbUL3EcK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 23:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbUL3EcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 23:32:09 -0500
Received: from [220.181.31.173] ([220.181.31.173]:16067 "HELO 126.com")
	by vger.kernel.org with SMTP id S261514AbUL3Eby (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 23:31:54 -0500
X-Originating-IP: [219.133.248.38]
Message-ID: <41D3847A.5090006@126.com>
Date: Thu, 30 Dec 2004 12:30:50 +0800
From: Walter Liu <Walter.liu@126.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Josef E. Galea" <josefeg@euroweb.net.mt>
CC: Coywolf Qi Hunt <coywolf@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Memory management in Linux
References: <41D2ABA8.2080906@euroweb.net.mt> <2cd57c900412290606f356334@mail.gmail.com> <41D2C8CD.8070001@euroweb.net.mt>
In-Reply-To: <41D2C8CD.8070001@euroweb.net.mt>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josef E. Galea wrote:

> Ok I may have got the name wrong :). What I am trying to do is to 
> implement a package on linux similiar to the TreadMarks by Alan Cox et 
> al. (ref. http://citeseer.ist.psu.edu/amza96treadmarks.html) that runs 
> at kernel level instead of user level. Right now I think that inorder 
> to achieve what I want to do, I have to change the code of the linux 
> virtual memory manager. This is ok for academic purposes (which is my 
> aim) however it severly reduces portability (it is much easier to just 
> load a kernel module than to patch and recompile the kernel).
>
Kernel-level thread or code can modify  mm_struct,vma,pde,pte,page 
protection bits,etc.
I think that it can modify  everything  in kernel.

Regards,
LWT

