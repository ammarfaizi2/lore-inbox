Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275512AbRIZTSM>; Wed, 26 Sep 2001 15:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275514AbRIZTSC>; Wed, 26 Sep 2001 15:18:02 -0400
Received: from mithra.wirex.com ([65.102.14.2]:51469 "HELO mail.wirex.com")
	by vger.kernel.org with SMTP id <S275512AbRIZTRu>;
	Wed, 26 Sep 2001 15:17:50 -0400
Message-ID: <3BB229D1.10401@wirex.com>
Date: Wed, 26 Sep 2001 12:17:37 -0700
From: Crispin Cowan <crispin@wirex.com>
Organization: WireX Communications, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-security-module@wirex.com,
        linux-kernel@vger.kernel.org
Subject: Re: Binary only module overview
In-Reply-To: <E15lfKE-00047d-00@the-village.bc.nu> <3BB10E8E.10008@wirex.com> <20010925202417.A16558@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Tue, Sep 25, 2001 at 04:09:02PM -0700, Crispin Cowan wrote:
>
>>Therefore, any additional constraints people may wish to impose, such as 
>>Greg's comment in security.h, are invalid. When someone receives a copy 
>>of the Linux kernel, the license is pure, vanilla GPL, with no funny 
>>riders.*
>>
>
>My comment in security.h that I proposed [1] does not add any additional
>constraints to the license that is currently on the file.  All it does
>is explicitly state the licensing terms of it, so that there shall be no
>confusion regarding it's inclusion in programs.  If you think this is
>adding an additional restriction to the file, please explain.
>
What your comment does is explicitly state your *interpretation* of the 
implications of the GPL. As is manifestly obvious, the GPL is subject to 
lots of interpretation, especially in the area of what is a "derived 
work." We are on the safest legal ground if we simply state that the 
file in question is GPL'd, and leave it at that.

>If you were to include a GPL licensed user space header file in a closed
>source program, of course you would be violating that license.
>
That is not clear to me. I have been unable to find a definitive 
reference that states that is the case.  If so, it is problematic, 
because then every user-land program that ever #include'd errno.h from 
glibc is GPL'd, because glibc #include's errno.h, among other GPL'd 
kernel header files. Are you sure you want to declare nearly all 
proprietary Linux applications to be in violation of the GPL?

We have a Schrodinger's Cat problem of whether the courts will 
eventually rule that modules are derivative works of the kernel. There 
are two cases here.  Either:

    * Binary modules are permitted by the kernel's GPL:  if this is the
      case, then Greg's comment is invalid, and misleading.
    * Binary modules are not permitted by the kernel's GPL: if this is
      the case, then Greg's comment is redundant, and just marking the
      file "GPL" is sufficient.

IMHO, in neither case is the special language appropriate. This file is 
GPL'd, and we should stop playing lawyer by trying to interpret what 
that means.

If you (Greg, Alan) are confident that your interpretation of the GPL is 
correct, then just marking the files as GPL should be sufficient. What 
purpose is served by saying anything else?

Crispin

-- 
Crispin Cowan, Ph.D.
Chief Scientist, WireX Communications, Inc. http://wirex.com
Security Hardened Linux Distribution:       http://immunix.org
Available for purchase: http://wirex.com/Products/Immunix/purchase.html


