Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315659AbSECTQX>; Fri, 3 May 2002 15:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315660AbSECTQW>; Fri, 3 May 2002 15:16:22 -0400
Received: from chaos.analogic.com ([204.178.40.224]:28288 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315659AbSECTQW>; Fri, 3 May 2002 15:16:22 -0400
Date: Fri, 3 May 2002 15:17:35 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Christoph Hellwig <hch@infradead.org>
cc: Tony Luck <aegl@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Virtual address space exhaustion (was  Discontigmem virt_to_page() )
In-Reply-To: <20020503200958.A30548@infradead.org>
Message-ID: <Pine.LNX.3.95.1020503151302.8450A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 May 2002, Christoph Hellwig wrote:

> On Fri, May 03, 2002 at 03:01:48PM -0400, Richard B. Johnson wrote:
> > The other Unix's I've become familiar are Sun-OS, the
> 
> SunOS 5 uses separate address spaces on sparcv9 (32 and 64bit).
> The same is true for many Linux ports, e.g. sparc64 or s390.
> 

No no! I'm not talking about the physical address spaces. Many
CPUs have separate address spaces for separate functions. I'm
taking about the virtual address space that the process sees.
There are no holes in this virtual address space of SunOS, and
no "separate stuff" (I/O space) seen by a user-mode task.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

