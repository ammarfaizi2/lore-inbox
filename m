Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316794AbSGZEvq>; Fri, 26 Jul 2002 00:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316821AbSGZEuc>; Fri, 26 Jul 2002 00:50:32 -0400
Received: from [195.63.194.11] ([195.63.194.11]:61189 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316794AbSGZEuS>; Fri, 26 Jul 2002 00:50:18 -0400
Message-ID: <3D409C3C.8090009@evision.ag>
Date: Fri, 26 Jul 2002 02:47:56 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: "Heinz J . Mauelshagen" <mauelshagen@sistina.com>,
       linux-kernel@vger.kernel.org, mge@sistina.com
Subject: Re: LVM 1.0.5 patch for Linux 2.4.19-rc3
References: <20020725153944.A8060@sistina.com> <20020725155433.A12776@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
>  
> +#ifndef	uchar
> +typedef	unsigned char	uchar;
> +#endif
> 
> Do you _really_ have to use this non-standard type?  can't you use the
> BSD u_char or sysv unchar?  and typedef/#define don't really mix nicely..

Or of course the normal u8 u16 and u32 and infally u64, which are so
much more explicit about the fact that we are actually dealig with
bit slices.

> 
> All in all this patch would be _soooo_ much easier to review if you wouldn't
> mix random indentation changes with real fixes.

Christoph applying the patch and rediffing with diffs "ingore white 
space' options can help you here.
And plese note that this kind of problems wouldn't be that common
if we finally decided to make indent -kr -i8 mandatory.


