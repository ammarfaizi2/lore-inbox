Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbUKHS1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUKHS1I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 13:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbUKHSYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 13:24:53 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:47301 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261174AbUKHSYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 13:24:05 -0500
Message-ID: <418FB9BF.1000809@mvista.com>
Date: Mon, 08 Nov 2004 12:23:59 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] small IPMI cleanup
References: <20041106222839.GS1295@stusta.de> <418FB0EA.90006@mvista.com> <20041108180656.GA15077@stusta.de>
In-Reply-To: <20041108180656.GA15077@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>>these functions that are perhaps not in the kernel yet (and perhaps 
>>never make it into the mainstream kernel).  Some of the statics do need 
>>to be cleaned up, though.
>>    
>>
>
>Why shouldn't they make it into the mainstream kernel?
>  
>
Sometimes people create specific tools that only support a specific type 
of board.  I'm not sure every single thing written to go into the kernel 
should be included i nthe mainstream kernel.  It's a hard call, but if 
it for some very specific thing then the vendor may not be interested in 
doing this.

>  
>
>>The IPMI driver was designed so that in-kernel users can use it as 
>>easily as userland users.  So these are important parts of the interface.
>>    
>>
>
>For userland users, a global kernel function (even if EXPORT_SYMBOL'ed) 
>is useless.
>  
>
Right, but it has to be there for the in-kernel users.

-Corey
