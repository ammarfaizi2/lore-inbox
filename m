Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbULIUPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbULIUPf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 15:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbULIUPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 15:15:35 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:55179 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261603AbULIUP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 15:15:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:return-path:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=H/H5XhfTMKAopqbVXC7aNTCXmDyoxlaUZEM90TTgkK/9i8L4H904fjHNHKiKXgMz59icP9B2+YHHWEQnFwVz3w/6k6Xm+Q0Y75fp31ZcG+D8R28G3bfiFHvPiVvT0IcfP/CAsSdcNGnrItPCUz6A5fDl/husycddige2kTNvIjk=
Message-ID: <41B76B7E.9020706@gmail.com>
Date: Thu, 09 Dec 2004 02:30:46 +0530
From: Imanpreet Singh Arora <imanpreet@gmail.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Question from Russells Spinlocks 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello there,

    I was reading Russell's guide on spinlocks, and I have some 
questions regarding it.


    Question-->    Russell says that in case of non-SMP machines 
spinlocks don't exist _at_ALL_. Well they should do something don't they 
like disable interrupts and premptations. I checked linux/spinlock well 
they DO NOT do anything atleast not when DEBUG_SPINLOCKS == 0. My 
understanding is that since they aren't used anywhere outside kernel and 
drivers(?), they can't be prempted. At least that is what I have read.


What does the comment about gcc while defining atomic_t signify?
             --> What about the comment about the limit of 24 bits on 
atomic_t?    
             a)    Atomic operations on integers are guranteed only if 
there value can be stored in 24 bits.
             b)    Atomic operations are guranteed only if the pointer 
has 8 MSbits set zero.


-- 
Imanpreet Singh Arora

Even if you are on the right track you are going to get runover if you just sit there.
	-- Will Rogers


