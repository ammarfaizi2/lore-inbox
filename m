Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbVJAWWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbVJAWWX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 18:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbVJAWWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 18:22:23 -0400
Received: from rrcs-67-78-243-58.se.biz.rr.com ([67.78.243.58]:5008 "EHLO
	mail.concannon.net") by vger.kernel.org with ESMTP id S1750873AbVJAWWW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 18:22:22 -0400
Message-ID: <433F0BF1.2020900@concannon.net>
Date: Sat, 01 Oct 2005 18:21:37 -0400
From: Michael Concannon <mike@concannon.net>
User-Agent: Mozilla Thunderbird 1.0.6-1.4.1.centos4 (X11/20050721)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: lokum spand <lokumsspand@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: A possible idea for Linux: Save running programs to disk
References: <BAY105-F35A25DA28443029610815DA48E0@phx.gbl> <1128202754.8153.0.camel@laptopd505.fenrus.org>
In-Reply-To: <1128202754.8153.0.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Sat, 2005-10-01 at 13:30 -0800, lokum spand wrote:
>  
>
>>I allow myself to suggest the following, although not sure if I post in
>>the right group:
>>
>>Suppose Linux could save the total state of a program to disk, for
>>instance, imagine a program like mozilla with many open windows. I give
>>it a SIGNAL-SAVETODISK and the process memory image is dropped to a
>>file. I can then turn off the computer and later continue using the
>>program where I left it, by loading it back into memory.
>>
>>Would that be possible? At least a program can be given a ctrl-z and is
>>    
>>
>
>there is a LOT of state though.. the moment you add networking in the
>picture the amount of state just isn't funny anymore. Your X example is
>a good one as well...
>  
>
There are a few cluster/parallel computing libraries out there that are 
starting to allow "process migration"...

One would assume that "saving it to a disk" is simply a degenerate case 
of migrating the process...

Presuming they have process migration working (and it seemed close a 
while ago when I last looked), saving to a file might already be 
supported...  I'd google "process migration" and you are likely to find 
a lot of discussion on this topic...

/mike

>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

