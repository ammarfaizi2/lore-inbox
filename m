Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267119AbRGJTf5>; Tue, 10 Jul 2001 15:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267112AbRGJTfs>; Tue, 10 Jul 2001 15:35:48 -0400
Received: from [64.64.109.142] ([64.64.109.142]:8722 "EHLO quark.didntduck.org")
	by vger.kernel.org with ESMTP id <S265593AbRGJTfi>;
	Tue, 10 Jul 2001 15:35:38 -0400
Message-ID: <3B4B58FE.642136EB@didntduck.org>
Date: Tue, 10 Jul 2001 15:35:26 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>, ttabi@interactivesi.com,
        linux-kernel@vger.kernel.org
Subject: Re: What is the truth about Linux 2.4's RAM limitations?
In-Reply-To: <200107101812.NAA01171@tomcat.admin.navo.hpc.mil> <3B4B4966.996DD91E@didntduck.org> <20010711064355.F32421@weta.f00f.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> 
> On Tue, Jul 10, 2001 at 02:28:54PM -0400, Brian Gerst wrote:
> 
>     Jesse Pollard wrote:
> 
>         > If the entire page table were given to a user, then a full cache
>         > flush would have to be done on every context switch and system
>         > call. That would be very slow, but would allow a full 4G address
>         > for the user.
> 
>     A full cache flush would be needed at every entry into the kernel,
>     including hardware interrupts.  Very poor for performance.
> 
> Why would a cache flush be necessary at all? I assume ia32 caches
> where physically not virtually mapped?

I meant TLB flush, sorry.

--

				Brian Gerst
