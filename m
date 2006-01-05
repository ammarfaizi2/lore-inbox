Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWAENiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWAENiO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 08:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWAENiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 08:38:14 -0500
Received: from hermes.ciemat.es ([130.206.11.6]:63492 "EHLO hermes.ciemat.es")
	by vger.kernel.org with ESMTP id S1751160AbWAENiN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 08:38:13 -0500
Date: Thu, 05 Jan 2006 14:39:07 +0100
From: =?UTF-8?B?Sm9zZSBHb256w6FsZXo=?= <jose.gonzalez@psa.es>
Subject: Re: socketpair - too many open files
In-reply-to: <1136467519.16358.19.camel@localhost.localdomain>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Message-id: <43BD217B.8030607@psa.es>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 8BIT
X-Accept-Language: es-es, en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922
 Fedora/1.7.12-1.3.1
References: <43BD0F5E.6020108@psa.es>
 <1136467519.16358.19.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Iau, 2006-01-05 at 13:21 +0100, Jose González wrote:
>  
>
>>Hello.
>>I am programming an application that need to create over 300 threads. 
>>Each thread calls socketpair function, but it returns EMFILE when it is 
>>called 150 times. Which kernel parameter can I change to do it?
>>    
>>
>
>Its a user space matter. See "ulimit -a" and find out how your
>distribution sets the default limits
>
>
>  
>
I modified this limit (open files, ulimit -n), even I have modified it 
in the kernel sources. I think that open file number isn't the problem.
Is there a limit in the open sockets?
