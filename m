Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268964AbUIHJEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268964AbUIHJEu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 05:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269030AbUIHJEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 05:04:50 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:15119 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S268964AbUIHJEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 05:04:35 -0400
Message-ID: <413ECC32.8070509@hist.no>
Date: Wed, 08 Sep 2004 11:09:06 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?UTF-8?B?R3J6ZWdvcnogSmHFm2tpZXdpY3o=?= <gryzman@gmail.com>
CC: Greg KH <greg@kroah.com>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <Pine.LNX.4.44.0408261607070.27909-100000@chimarrao.boston.redhat.com> <200408290004.i7T04DEO003646@localhost.localdomain> <20040901224513.GM31934@mail.shareable.org> <20040903082256.GA17629@kroah.com> <2f4958ff04090301326e7302c1@mail.gmail.com> <41383142.4080201@hist.no> <2f4958ff04090302141bc222e5@mail.gmail.com>
In-Reply-To: <2f4958ff04090302141bc222e5@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Jaśkiewicz wrote:

>On Fri, 03 Sep 2004 10:54:26 +0200, Helge Hafting <helge.hafting@hist.no> wrote:
>  
>
>>Grzegorz Jaśkiewicz wrote:
>>
>>    
>>
>>>devfs was very natural, and simple solution. But to have it right, it
>>>would have to be the only /dev filesystem.
>>>But no, we like choices, so we have chaos.
>>>Udev is just another thing adding to that chaos.
>>>
>>>Someone was numbering things that are good in BSD design, in that
>>>thread. One of those things was going for devfs. No cheap solutions.
>>>One fs for /dev. And it works great.
>>>
>>>Sorry for bit of trolling.
>>>
>>>
>>>      
>>>
>>Devfs was a ver good idea.  The implementation of it
>>was a problem, and after some time nobody maintained it.
>>No surprise it had to go.  Now udev+tmpfs can do the same
>>job, and more.
>>    
>>
>
>udef is a one big mistake, having need for userspace tool to use FS is
>at least silly.
>  
>
Well, devfs had devfsd - a userspace tool . . .

>I can understeand need for some things in kernel to have userspace
>daemon. But FS is out of question the least one.
>
>I am supprised noone wanted to maintain devfs. 
>
I believe it had soemthing to do with the design - in order
to fix it you had to rewrite it almost from scratch.  People
work on whatever they want to, and devfs wasn't it.

>Maybe because people
>didn't want to go to devfs only. But still to have classic /dev. It's
>also silly, because person writing driver needs to choose between, or
>implement all. That's more than bad. Once I have loads of time, and no
>work in KDE, I can take over devfs happily :-)
>  
>
Go ahead!  Perhaps you get it right.  Then you'll have to
convince users of udev (or plain old /dev) that your way is better.

Helge Hafting
