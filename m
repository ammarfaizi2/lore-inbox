Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbTKEOHV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 09:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbTKEOHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 09:07:21 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:48855 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262914AbTKEOHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 09:07:18 -0500
Message-ID: <3FA85B4C.1040900@namesys.com>
Date: Tue, 04 Nov 2003 18:07:08 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Oeser <ioe-lkml@rameria.de>
CC: Nikita Danilov <Nikita@Namesys.COM>, "Theodore Ts'o" <tytso@mit.edu>,
       Erik Andersen <andersen@codepoet.org>, linux-kernel@vger.kernel.org,
       Timothy Miller <miller@techsource.com>
Subject: Re: Things that Longhorn seems to be doing right
References: <3F9F7F66.9060008@namesys.com> <3FA6891A.3050400@techsource.com> <3FA75F97.3080508@namesys.com> <200311051451.10063.ioe-lkml@rameria.de>
In-Reply-To: <200311051451.10063.ioe-lkml@rameria.de>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:

>On Tuesday 04 November 2003 09:13, Hans Reiser wrote:
>  
>
>>Timothy Miller wrote:
>>    
>>
>>>Nikita Danilov wrote:
>>>      
>>>
>>>>It is called "a directory". :) There is no crime in putting
>>>>
>>>>cc src/*.c
>>>>
>>>>into Makefile. I think that Hans' query-result-object denoting multiple
>>>>objects is more like directory than single regular file.
>>>>        
>>>>
>>>So a file system query that results in multiple files generates a
>>>"virtual directory"?
>>>      
>>>
>>Remember that this code does not exist yet.....;-)
>>
>>Sounds like it might be a good way to do it though.
>>    
>>
>
>Yes and this also solves the "refine feedback" problem: Just return
>sth. useful in the stat->nlink for that directory
>or even create a new stat-like syscall.
>  
>
I don't understand what you are saying about nlink.  Can you say more?

>Now the issuer can decide on ANY level, whether to refine the search or
>accept the result to present it in a listing.
>
>A proper replacement for nlink is looong overdue.
>
>But even with the crappy one, we have now, it can be decided since a
>list of 65K is too much for a proper selection and cannot be handled by
>a user. Somebody even said that every search pattern revealing more
>than 50 records is not refined enough.
>  
>
If the user is looking for only one record....

>PS: Hans, we just saved you the funding on this topic.
>
>Regards
>
>Ingo Oeser
>
>
>
>
>  
>


-- 
Hans


