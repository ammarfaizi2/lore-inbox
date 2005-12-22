Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbVLWAn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbVLWAn5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 19:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbVLWAn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 19:43:56 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:21404 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S1751229AbVLWAn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 19:43:56 -0500
Message-ID: <43AB32C1.1080101@wolfmountaingroup.com>
Date: Thu, 22 Dec 2005 16:12:01 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, legal@lists.gnumonks.org,
       linux-fsdevel@vger.kernel.org,
       LKML Kernel <linux-kernel@vger.kernel.org>,
       "Robert W. Fuller" <garbageout@sbcglobal.net>
Subject: Re: blatant GPL violation of ext2 and reiserfs filesystem drivers
References: <43AACF77.9020206@sbcglobal.net>	 <496FC071-3999-4E23-B1A2-1503DCAB65C0@mac.com> <1135283241.12761.19.camel@localhost.localdomain>
In-Reply-To: <1135283241.12761.19.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:

>On Thu, 2005-12-22 at 13:01 -0500, Kyle Moffett wrote:
>  
>
>>On Dec 22, 2005, at 11:08, Robert W. Fuller wrote:
>>    
>>
>>>Please see the following thread:
>>>
>>>http://www.opensolaris.org/jive/thread.jspa?threadID=2132&tstart=0x
>>>
>>>Sorry I didn't get around to reporting this sooner, but at least  
>>>the guilty party has had plenty of time to fail to repent.
>>>
>>>Regards,
>>>
>>>Rob
>>>      
>>>
>>This case looks about as black and white as it gets (although IANAL),  
>>so I'm adding gpl-violations.org-legal to the CC list.
>>    
>>
>
>I'm not sure this is the case here or not, but it definitely brings up
>an interesting question.
>
>Since the dynamic loading of binary modules into Linux seems to be a
>gray area, since if I give you a binary module that loads into Linux,
>but except for the API found in the header files, the module contains no
>GPL code. Is it bound to the GPL?  This is a rhetorical question, please
>don't answer it.
>
>Now the real question:  If one were to have an operating system, and set
>up a layer that simulated the API of Linux, such that Linux binary
>modules could be loaded, is _that_ a violation of the GPL?  
>

No , it is not.  It's called "reverse engineering".

Jeff

>IOW, one
>would only distribute to you a system that has no GPL code, and only
>simulates an API, which is legal otherwise Samba wouldn't exist. But the
>user has the option of compiling a Linux module to get the benefits from
>it.  Sort of a ndiswrapper in reverse!
>
>-- Steve
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

