Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311277AbSCQD3a>; Sat, 16 Mar 2002 22:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311281AbSCQD3T>; Sat, 16 Mar 2002 22:29:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43278 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311277AbSCQD3I>; Sat, 16 Mar 2002 22:29:08 -0500
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
To: cw@f00f.org (Chris Wedgwood)
Date: Sun, 17 Mar 2002 03:43:29 +0000 (GMT)
Cc: ak@suse.de (Andi Kleen), yodaiken@fsmlabs.com,
        paulus@samba.org (Paul Mackerras), linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
In-Reply-To: <20020317025004.GA13644@tapu.f00f.org> from "Chris Wedgwood" at Mar 16, 2002 06:50:04 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16mRZx-00085G-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     They are not supported for user space, but used in private
>     mappings for kernel text and direct memory mappings. Generic code
>     never sees them.
> 
> Is there any reason we couldn't use them for mapping large
> frame-buffers and similar?

You are labouring under the belief that processors touch the frame buffer
nowdays. For a current accelerated frame buffer that isnt very true.
