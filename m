Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289290AbSAIJRB>; Wed, 9 Jan 2002 04:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289287AbSAIJQw>; Wed, 9 Jan 2002 04:16:52 -0500
Received: from [195.63.194.11] ([195.63.194.11]:9225 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S289290AbSAIJQl>;
	Wed, 9 Jan 2002 04:16:41 -0500
Message-ID: <3C3C07D1.4090209@evision-ventures.com>
Date: Wed, 09 Jan 2002 10:05:21 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: jtv <jtv@xs4all.nl>, Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: __FUNCTION__
In-Reply-To: <3C3B664B.3060103@intel.com> <20020108220149.GA15816@kroah.com> <20020108235649.A26154@xs4all.nl> <20020108231147.GA16313@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Tue, Jan 08, 2002 at 11:56:49PM +0100, jtv wrote:
>
>>Don't have a C99 spec, but here's what info gcc has to say about it:
>>
>>[...description of "function names" extension as currently found in gcc...]
>>
>>   Note that these semantics are deprecated, and that GCC 3.2 will
>>handle `__FUNCTION__' and `__PRETTY_FUNCTION__' the same way as
>>`__func__'.  `__func__' is defined by the ISO standard C99:
>>
>
>Any reason _why_ they would want to break tons of existing code in this
>manner?  Just the fact that the __func__ symbol is there to use?
>
String constant coalescing chances. It is a good thing. Anobody who used 
__FUNCTION__ which was
neither a proper preprocessor constant nor a proper variable 
semantically was in problem.

