Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280114AbRKRV3e>; Sun, 18 Nov 2001 16:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277861AbRKRV3Y>; Sun, 18 Nov 2001 16:29:24 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:62121 "EHLO
	c0mailgw12.prontomail.com") by vger.kernel.org with ESMTP
	id <S280110AbRKRV3K>; Sun, 18 Nov 2001 16:29:10 -0500
Message-ID: <3BF827E1.5A2C7427@starband.net>
Date: Sun, 18 Nov 2001 16:28:01 -0500
From: war <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: James A Sutherland <jas88@cam.ac.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Swap
In-Reply-To: <3BF82443.5D3E2E11@starband.net> <E165ZRi-000718-00@mauve.csi.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, without the swap, everything seems to be about 100% more responsive when
I execute any task.
I see how it works now.

James A Sutherland wrote:

> On Sunday 18 November 2001 9:12 pm, war wrote:
> > It is amazing that I could run all of that stuff, because:
> >
> > When I have swap on, and if I run all of those programs, 200-400MB of
> > swap is used.
>
> Yep. There's a reason for that: the kernel is *ALWAYS* able to swap pages out
> to disk - even without "swap space". Disabling swapspace simply forces the
> kernel to swap out more code, since it cannot swap out any data.
>
> (This is why you can still get "disk thrashing" without any swap - in fact,
> it's more likely in this case than it is with some swap added - you are just
> forcing your binaries to take more of the swapping load instead.)
>
> So: with swapspace, the kernel swaps out a few hundred Mb of unused data, to
> make room for more code. Without it, the kernel is forced to swap out code
> pages instead. The big news here is...?
>
> James.

