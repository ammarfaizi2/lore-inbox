Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275676AbRIZWum>; Wed, 26 Sep 2001 18:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275679AbRIZWud>; Wed, 26 Sep 2001 18:50:33 -0400
Received: from mithra.wirex.com ([65.102.14.2]:21002 "HELO mail.wirex.com")
	by vger.kernel.org with SMTP id <S275676AbRIZWuZ>;
	Wed, 26 Sep 2001 18:50:25 -0400
Message-ID: <3BB25BA3.1060505@wirex.com>
Date: Wed, 26 Sep 2001 15:50:11 -0700
From: Crispin Cowan <crispin@wirex.com>
Organization: WireX Communications, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-security-module@wirex.com,
        linux-kernel@vger.kernel.org
Subject: Re: Binary only module overview
In-Reply-To: <E15lfKE-00047d-00@the-village.bc.nu> <3BB10E8E.10008@wirex.com> <20010925202417.A16558@kroah.com> <3BB229D1.10401@wirex.com> <20010926130156.B19819@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Wed, Sep 26, 2001 at 12:17:37PM -0700, Crispin Cowan wrote:
>
>>Greg KH wrote:
>>
>>>If you were to include a GPL licensed user space header file in a closed
>>>source program, of course you would be violating that license.
>>>
>>That is not clear to me. [... #include glibc -> #include kernel]
>>
>That is an issue to take up with the glibc authors, not me.
>
Fair enough. I pointed it out to make clear that there are licensing 
problems and ambiguities if one strictly insists that #include 
some_gpl.h implies that the code is GPL'd. If that is the case, then 
there are MUCH bigger licensing problems than LSM, so don't take it up 
with me, either :-)

>>If you (Greg, Alan) are confident that your interpretation of the GPL is 
>>correct, then just marking the files as GPL should be sufficient. What 
>>purpose is served by saying anything else?
>>
>As Alan stated, to reduce confusion as to the wishes of the copyright
>holders of the file.
>
However, it is an outright contradiction to some wishes of some other 
copyright holders of the kernel (Linus' binary kernel opinion). Since 
revisions to the kernel's GPL are explicitly prohibited, it seems to me 
that this statement of one side of the controversy as if it were a fact 
increases confusion rather than decreases it.

>a small note in it detailing this disagreement might be a nice thing to do.
>
Fair enough.  How about this:

    "This file is GPL. See the Linux Kernel's COPYING file for details.
    There is controversy over whether this permits you to write a module
    that #includes this file without placing your module under the GPL.
    Consult your lawyer for advice."

I'm really trying to be constructive here.  There is a real licensing 
problem over whether binary modules are legitimate at all, and the issue 
is not special to LSM. I'm trying to get LSM out of the way so that the 
advocates of either side can fight it out without smushing LSM in the 
middle :-)

Crispin

-- 
Crispin Cowan, Ph.D.
Chief Scientist, WireX Communications, Inc. http://wirex.com
Security Hardened Linux Distribution:       http://immunix.org
Available for purchase: http://wirex.com/Products/Immunix/purchase.html



