Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261861AbRE2VFQ>; Tue, 29 May 2001 17:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261894AbRE2VFG>; Tue, 29 May 2001 17:05:06 -0400
Received: from wb3-a.mail.utexas.edu ([128.83.126.138]:50948 "HELO
	mail.utexas.edu") by vger.kernel.org with SMTP id <S261861AbRE2VEx>;
	Tue, 29 May 2001 17:04:53 -0400
Message-ID: <3B136639.D883F0C8@mail.utexas.edu>
Date: Tue, 29 May 2001 15:04:57 +0600
From: "Bobby D. Bryant" <bdbryant@mail.utexas.edu>
Organization: (I do not speak for) The University of Texas at Austin (nor they for 
 me).
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-athlon i686)
X-Accept-Language: en,fr,de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Status of ALi MAGiK 1 support in 2.4.?
In-Reply-To: <E154iiK-0004Mb-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > May 22 21:45:07 pollux kernel: ALI15X3: simplex device:  DMA disabled
> > May 22 21:45:07 pollux kernel: ide0: ALI15X3 Bus-Master DMA disabled
> > (BIOS)
> > May 22 21:45:07 pollux kernel: ALI15X3: simplex device:  DMA disabled
> > May 22 21:45:07 pollux kernel: ide1: ALI15X3 Bus-Master DMA disabled
>
> The DMA was off because the BIOS left it off.

I just checked, and the BIOS auto-detect page for that drive shows PIO Mode 4
and Ultra DMA Mode 5.  The BIOS also shows a summary chart during boot, just
before the LILO prompt, and that summary also reports UDMA 5 for that drive. It
really looks like the kernel is not getting the correct device info from the
BIOS.

As I mentioned earlier, the A7A266 supposedly has an ALi M1535D+ southbridge
"with PCI Super-I/O Integrated Peripheral Controller (PSIPC)", rather than the
ALI15X3 reported by the kernel.

Thanks,

Bobby Bryant
Austin, Texas


