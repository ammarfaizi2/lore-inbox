Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280297AbRJaQyL>; Wed, 31 Oct 2001 11:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280298AbRJaQyB>; Wed, 31 Oct 2001 11:54:01 -0500
Received: from [207.8.4.6] ([207.8.4.6]:64131 "EHLO one.interactivesi.com")
	by vger.kernel.org with ESMTP id <S280297AbRJaQxq>;
	Wed, 31 Oct 2001 11:53:46 -0500
Message-ID: <3BE02C94.4020007@interactivesi.com>
Date: Wed, 31 Oct 2001 10:53:40 -0600
From: Timur Tabi <ttabi@interactivesi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Module Licensing?
In-Reply-To: <E15yjCb-0001q7-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>Ah, but what happens if I distribute the source code, the closed-source .o 
>>files, and a makefile, and tell people that they should link it?  Am I 
>>violating the GPL, or is the end-user?
>>
> 
> I am told by legal people you are, because you provided the code soley with
> the intent that it was used that way. Whether an imaginative lawyer can
> also get you locked away under the DMCA for distributing a device for
> violating copyright I dont know 8)


But the GPL only covers distribution, not use.  Just because I distribute GPL 
source code, doesn't mean that it actually has to work or do something.  The 
open source portions of the driver conform to the GPL, because they #include 
kernel header files and, in some case, cut-and-paste from the kernel source 
itself.  The closed source portions do not #include any kernel header files or 
  use any source code from anyone else.

The fact that the open source portions and the closed source portions can't 
function on their own is irrelevant, IMHO.

Please show me where in the GPL text it says that the act of compiling a 
module and loading it into memory is subject to the GPL.

> If you wanted to provide a mixed source/binary driver that wasnt derivative
> of the kernel (and there are lots of reasons for it) - don't GPL your 
> open source bit use something like MPL or BSD


Our open source bits are GPL because they are "derived" from the kernel 
source, which is also GPL.

FYI, I don't consider including a header file basis for calling the module 
"derived" from that header file, but that's just my personal opinion and 
doesn't really affect this discussion.

