Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWDXWKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWDXWKX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 18:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWDXWKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 18:10:22 -0400
Received: from ns1.soleranetworks.com ([70.103.108.67]:52107 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S1751068AbWDXWKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 18:10:22 -0400
Message-ID: <444D57F0.1070105@wolfmountaingroup.com>
Date: Mon, 24 Apr 2006 16:57:52 -0600
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Martin Mares <mj@ucw.cz>, Gary Poppitz <poppitzg@iomega.com>,
       linux-kernel@vger.kernel.org
Subject: Re: C++ pushback
References: <4024F493-F668-4F03-9EB7-B334F312A558@iomega.com>	 <mj+md-20060424.201044.18351.atrey@ucw.cz>	 <444D44F2.8090300@wolfmountaingroup.com> <1145915533.1635.60.camel@localhost.localdomain>
In-Reply-To: <1145915533.1635.60.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Llu, 2006-04-24 at 15:36 -0600, Jeff V. Merkey wrote:
>  
>
>>C++ in the kernel is a BAD IDEA. C++ code can be written in such a 
>>convoluted manner as to be unmaintainable and unreadable.
>>    
>>
>
>So can C. 
>
>  
>
>>All of the hidden memory allocations from constructor/destructor 
>>operatings can and do KILL OS PERFORMANCE. 
>>    
>>
>
>This is one area of concern. Just as big a problem for the OS case is
>that the hidden constructors/destructors may fail. You can write C++
>code carefully to avoid these things but it can be hard to see where the
>problem is when you miss one.
>
>C at least makes it verbose, but we trade that for poorer typechecking
>and visibility control.
>
>Alan
>  
>

Yep.

Jeff

>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

