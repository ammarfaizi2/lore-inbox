Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268011AbUIFNje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268011AbUIFNje (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 09:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268013AbUIFNjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 09:39:33 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:38660 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S268011AbUIFNj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 09:39:29 -0400
Message-ID: <413C699C.5050900@hist.no>
Date: Mon, 06 Sep 2004 15:43:56 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Spam <spam@tnonline.net>, Oliver Hunt <oliverhunt@gmail.com>,
       Hans Reiser <reiser@namesys.com>, Linus Torvalds <torvalds@osdl.org>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Adrian Bunk <bunk@fs.tum.de>, viro@parcelfarce.linux.theplanet.co.uk,
       Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
References: <200409040227.i842R7io003637@localhost.localdomain>
In-Reply-To: <200409040227.i842R7io003637@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:

>Spam <spam@tnonline.net> said:
>  
>
>>Horst von Brand <vonbrand@inf.utfsm.cl> said:
>>    
>>
>>>Helge Hafting <helge.hafting@hist.no> said:
>>>      
>>>
>>>[...]
>>>      
>>>
>>>>The only new thing needed is the ability for something to be both
>>>>file and directory at the same time.
>>>>        
>>>>
>>>Then why have files and directories in the first place?
>>>      
>>>
>
>  
>
>>  Good point, we don't need them :)
>>    
>>
>
>Great. Then everything is a firectory (or dile?). And a firectory points at
>other firectories and contains data. I just don't see how you are supposed
>to distinguish the data from further firectories...
>  
>
By name.
fopen("somefile", "r");  //opens somefile data
fopen("somefile/substream", "r");  //opens a substream of somefile. 

Helge Hafting
