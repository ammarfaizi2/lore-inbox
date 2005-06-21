Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261954AbVFUOQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbVFUOQf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 10:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbVFUOOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 10:14:31 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:48105 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S261980AbVFUOJQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 10:09:16 -0400
Message-ID: <42B81F82.2020509@unice.fr>
Date: Tue, 21 Jun 2005 16:09:06 +0200
From: XIAO Gang <xiao@unice.fr>
Organization: =?ISO-8859-1?Q?Universit=E9_de_Nice_-_Sophia_Anti?=
 =?ISO-8859-1?Q?polis?=
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, fr, zh-CN, zh-TW
MIME-Version: 1.0
To: Jeff Dike <jdike@addtoit.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: UML mode panick under 2.6.12
References: <42B7C0FA.8070409@unice.fr> <20050621130319.GA4510@ccure.user-mode-linux.org>
In-Reply-To: <20050621130319.GA4510@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:

>On Tue, Jun 21, 2005 at 09:25:46AM +0200, XIAO Gang wrote:
>  
>
>>I am unable to run UML mode (i386) under 2.6.12: the execution gives the 
>>following messages.
>>
>>---------------------------------------------------------------------------------------------
>>    
>>
>
>  
>
>>Checking that ptrace can change system call numbers...<0>Kernel panic - 
>>not syncing: Segfault with no mm
>>    
>>
>
>Can you try backing out the use-fork-instead-of-clone patch?  Ben LaHaise
>reported that caused problems for him.
>  
>
Not wanting to bother trimming things out, I have just copied 
arch/um/kernel/process.c from that in 2.6.10 then recompile. And 
everything works fine. So the problem is there, but I don't know how 
exactly.

-- 

XIAO Gang (~{P$8U~})                          xiao@unice.fr
          home page: pcmath126.unice.fr/xiao.html 



