Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWH1SGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWH1SGE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 14:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWH1SGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 14:06:04 -0400
Received: from mail.zelnet.ru ([80.92.97.13]:692 "EHLO mail.zelnet.ru")
	by vger.kernel.org with ESMTP id S1750725AbWH1SGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 14:06:01 -0400
Message-ID: <44F3307C.8070704@namesys.com>
Date: Mon, 28 Aug 2006 22:05:48 +0400
From: Edward Shishkin <edward@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060411
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Jindrich Makovicka <makovick@gmail.com>
CC: David Masover <ninja@slaphack.com>, Andrew Morton <akpm@osdl.org>,
       Alexey Dobriyan <adobriyan@gmail.com>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: Reiser4 und LZO compression
References: <20060827003426.GB5204@martell.zuzino.mipt.ru>	<20060827010428.5c9d943b.akpm@osdl.org>	<44F16923.9050609@slaphack.com> <20060828193401.5232e23c@holly.localdomain>
In-Reply-To: <20060828193401.5232e23c@holly.localdomain>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jindrich Makovicka wrote:
> On Sun, 27 Aug 2006 04:42:59 -0500
> David Masover <ninja@slaphack.com> wrote:
> 
> 
>>Andrew Morton wrote:
>>
>>>On Sun, 27 Aug 2006 04:34:26 +0400
>>>Alexey Dobriyan <adobriyan@gmail.com> wrote:
>>>
>>>
>>>>The patch below is so-called reiser4 LZO compression plugin as
>>>>extracted from 2.6.18-rc4-mm3.
>>>>
>>>>I think it is an unauditable piece of shit and thus should not
>>>>enter mainline.
>>>
>>>Like lib/inflate.c (and this new code should arguably be in lib/).
>>>
>>>The problem is that if we clean this up, we've diverged very much
>>>from the upstream implementation.  So taking in fixes and features
>>>from upstream becomes harder and more error-prone.
>>
>>Well, what kinds of changes have to happen?  I doubt upstream would
>>care about moving some of it to lib/ -- and anyway, reiserfs-list is
>>on the CC.  We are speaking of upstream in the third party in the
>>presence of upstream, so...
> 
> 
> The ifdef jungle is ugly, and especially the WIN / 16-bit DOS stuff is
> completely useless here.
> 

I agree that it needs some brushing,
putting in todo..


> 
>>Maybe just ask upstream?
> 
> 
> I am not sure if Mr. Oberhumer still cares about LZO 1.x, AFAIK he now
> develops a new compressor under a commercial license.
> 
> Regards,

