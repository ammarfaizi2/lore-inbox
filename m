Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265024AbRGEMhG>; Thu, 5 Jul 2001 08:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265042AbRGEMg4>; Thu, 5 Jul 2001 08:36:56 -0400
Received: from [202.140.153.5] ([202.140.153.5]:20997 "EHLO
	techctd.techmas.hcltech.com") by vger.kernel.org with ESMTP
	id <S265024AbRGEMgo>; Thu, 5 Jul 2001 08:36:44 -0400
Message-ID: <3B445FA5.8CB55F45@techmas.hcltech.com>
Date: Thu, 05 Jul 2001 18:07:57 +0530
From: Vasu Varma P V <pvvvarma@techmas.hcltech.com>
Organization: HCL Technologies
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: arjanv@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: Re: DMA memory limitation?
In-Reply-To: <3B4453E6.F4342781@techmas.hcltech.com> <3B44558A.B52B5C60@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

but we have a macro in include/asm-i386/dma.h,
MAX_DMA_ADDRESS  (PAGE_OFFSET+0x1000000).

if i change it to a higher value, i am able to get more dma
memory. Is there any way i can change this without compiling
the kernel?

Arjan van de Ven wrote:

> Vasu Varma P V wrote:
> >
> > Hi,
> >
> > Is there any limitation on DMA memory we can allocate using
> > kmalloc(size, GFP_DMA)? I am not able to acquire more than
> > 14MB of the mem using this on my PCI SMP box with 256MB ram.
> > I think there is restriction on ISA boards of 16MB.
> > Can we increase it ?
>
> Why?
> YOu don't have to allocate GFP_DMA memory for PCI cards!
> GFP_DMA is for ISA cards only

