Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbVLGOTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbVLGOTA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 09:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbVLGOTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 09:19:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38274 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751079AbVLGOS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 09:18:59 -0500
Message-ID: <4396EF50.30201@redhat.com>
Date: Wed, 07 Dec 2005 09:18:56 -0500
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Kenny Simpson <theonetruekenny@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: another nfs puzzle
References: <20051206220448.82860.qmail@web34109.mail.mud.yahoo.com>	 <4396EB2F.3060404@redhat.com> <1133964667.27373.13.camel@lade.trondhjem.org>
In-Reply-To: <1133964667.27373.13.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>On Wed, 2005-12-07 at 09:01 -0500, Peter Staubach wrote:
>  
>
>>Kenny Simpson wrote:
>>
>>    
>>
>>>Hi again,
>>> I am seeing some odd behavior with O_DIRECT.  If a file opened with O_DIRECT has a page mmap'd,
>>>and the file is extended via pwrite, then the mmap'd region seems to get lost - i.e. it neither
>>>takes up system memory, nor does it get written out.
>>> 
>>>
>>>      
>>>
>>I don't think that I understand why or how the kernel allows a file,
>>which was opened with O_DIRECT, to be mmap'd.  The use of O_DIRECT
>>implies no caching and mmap implies the use of caching.
>>    
>>
>
>In this context it doesn't matter whether or not the you use the same
>file descriptor. The problem is the same if my process opens the file
>for O_DIRECT and then your process open it for normal I/O, and mmaps it.
>

Yup, same problem.  Why is this allowed?  Does it really work correctly?

    Thanx...

       ps
