Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbTDROHq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 10:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbTDROHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 10:07:46 -0400
Received: from watch.techsource.com ([209.208.48.130]:49640 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S263056AbTDROHp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 10:07:45 -0400
Message-ID: <3EA00D04.6090705@techsource.com>
Date: Fri, 18 Apr 2003 10:34:44 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] only use 48-bit lba when necessary
References: <200304172137_MC3-1-34EB-2D39@compuserve.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chuck Ebbert wrote:

>Matt Mackall wrote:
>
>
>  
>
>>FYI, GCC as of 3.2.3 doesn't yet reduce the if(...) form to branchless
>>code but the & and && versions come out the same with -O2.
>>    
>>
>
>
>  The operands of & can be evaluated in any order, while && requires
>left-to-right and does not evaluate the right operand if the left one
>is false.  Only the simplest cases could possibly generate the same
>code.
>
>  
>
I have a vague memory of reading a kerneltrap.org article or comment 
thread which discussed this.  The determination was that a compiler 
could choose to fully evaluate the logical expression if there were no 
side-effects.



