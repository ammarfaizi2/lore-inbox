Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268284AbUIGSGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268284AbUIGSGe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 14:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268254AbUIGSGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 14:06:09 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:2286 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268247AbUIGSFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:05:46 -0400
Message-ID: <413DF873.1090304@namesys.com>
Date: Tue, 07 Sep 2004 11:05:39 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Spam <spam@tnonline.net>, Christer Weinigel <christer@weinigel.se>,
       David Masover <ninja@slaphack.com>, Tonnerre <tonnerre@thundrix.ch>,
       Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <200409071530.i87FUCP1003927@laptop11.inf.utfsm.cl>
In-Reply-To: <200409071530.i87FUCP1003927@laptop11.inf.utfsm.cl>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:

>Spam <spam@tnonline.net> said:
>  
>
>>Christer Weinigel <christer@weinigel.se> said:
>>    
>>
>
>[...]
>
>  
>
>>>Could you please try summarize a few of the arguments that you find
>>>especially compelling?  This thread has gotten very confused since
>>>there are a bunch of different subjects all being intermixed here.
>>>      
>>>
>
>  
>
>>  Indeed. We are discussion changes to the heart of Linux. It is bound
>>  to get a little heated :/
>>    
>>
>
>True. But without any specific applications, just "this would be nice to
>have", the discussion can't go forward.
>
>  
>
>>>What are we discussing?
>>>      
>>>
>
>  
>
>>>1. Do we want support for named streams?
>>>      
>>>
>>>   I belive the answer is yes, since both NTFS and HFS (that's the
>>>   MacOS filesystem, isn't it?) supports streams we want Linux to
>>>   support this if possible.
>>>      
>>>
>>>   Anyone disagreeing?
>>>      
>>>
>>     No :)
>>    
>>
>
>There are many people around here who disagree (that is precisely the heart
>of the discussion). I for one don't think Linux has to get $RANDOM_FEATURE
>just because $SOME_OTHER_OS has got it. Either the feature stands on its
>own _in the context of POSIX/Unix/Linux_ (possibly as an extension or
>modification of said standards) or it isn't worth it.
>
>  
>
>>>2. How do we want to expose named streams?
>>>      
>>>
>>>   One suggestion is file-as-directory in some form.
>>>      
>>>
>
>Which is broken, as it forbids hard links to files.
>  
>
No, it forbids hard links to the directory aspect of the file-directory 
duality.

>
>
>Now you have 3 principal types of objects: Directories, containers (files
>with streams), and files (no streams).
>
No, the reiser4 design supports only files and directories, but makes 
them able to do what people use streams for.

The reiser4 design is based on a hatred of streams, and a desire to show 
that adding more features to files and directories makes streams 
unnecessary.

Hans
