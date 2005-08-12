Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbVHLOVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbVHLOVp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 10:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbVHLOVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 10:21:45 -0400
Received: from smtp102.rog.mail.re2.yahoo.com ([206.190.36.80]:56238 "HELO
	smtp102.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750971AbVHLOVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 10:21:44 -0400
Message-ID: <42FCB06A.5050609@masoud.ir>
Date: Fri, 12 Aug 2005 10:21:30 -0400
From: Masoud Sharbiani <masouds@masoud.ir>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.3) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grant Coady <Grant.Coady@gmail.com>
CC: "Vladimir V. Saveliev" <vs@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: Via-Rhine NIC, Via SATA or reiserfs broken, how to tell??
References: <54nnf1tv8722aq6med3mlr4mvg7nli0r09@4ax.com> <42FC7D5E.8020604@namesys.com> <mc2pf1tgih72uq4flc3hl6q0897r060ilp@4ax.com>
In-Reply-To: <mc2pf1tgih72uq4flc3hl6q0897r060ilp@4ax.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you turn on UDP checksums and try again? That would isolate the 
fault between the network or SATA.
cheers,
Masoud
Grant Coady wrote:

>On Fri, 12 Aug 2005 14:43:42 +0400, "Vladimir V. Saveliev" <vs@namesys.com> wrote:
>  
>
>>>How to test and isolate this error is in NIC driver, SATA driver or 
>>>filesystem?  
>>>
>>>      
>>>
>>Could it be that tarbal on NFS server changed?
>>It is not very likely that error in kernel drivers fixed typos in source code.
>>    
>>
>
>The 'typos' are the observed errors from extracting kernel source tarball, 
>renaming top level directory and extracting tarball again.  Other times 
>extraction fails with corrupt tarball error.  Cached image of tarball is 
>corrupted as box doesn't go back to server.
>
>Since first report I've changed to using ext2 target filesystem, still get 
>errors, so not reiserfs specific either.  
>
>Am in process of reducing options in kernel config, try to narrow down 
>what problem is.  Nothing in logs, me have no idea ... yet.  
>
>Not a memory error as box compiled many hundred kernels last week without 
>choking.  Test just now was with 2.6.13-rc6-git3, very repeatable.
>
>Same test on different box, no errors.  Other box has pro/100 NIC, 
>reiserfs, unpack tarball from same server.  Never a problem.
>
>Cheers,
>Grant.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


