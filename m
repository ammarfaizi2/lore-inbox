Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131158AbREEGJE>; Sat, 5 May 2001 02:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131446AbREEGIy>; Sat, 5 May 2001 02:08:54 -0400
Received: from wb2-a.mail.utexas.edu ([128.83.126.136]:15109 "HELO
	mail.utexas.edu") by vger.kernel.org with SMTP id <S132527AbREEGIl>;
	Sat, 5 May 2001 02:08:41 -0400
Message-ID: <3AF2F07E.545BBDDB@mail.utexas.edu>
Date: Sat, 05 May 2001 00:10:06 +0600
From: "Bobby D. Bryant" <bdbryant@mail.utexas.edu>
Organization: (I do not speak for) The University of Texas at Austin (nor they for 
 me).
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en,fr,de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: REVISED: Experimentation with Athlon and fast_page_copy
In-Reply-To: <E14vmpN-000822-00@the-village.bc.nu> <006e01c0d4e9$3c0bd210$0300a8c0@methusela>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Tiensivu wrote:

> > What still stands out is that exactly _zero_ people have reported the same
> > problem with non VIA chipset Athlons.
>
> This might be grasping at straws [...] This could be (total conjecture)

> related somehow to the corruption bugs they are admitting to in

> the 686B although they are blaming the SB Live now.

Just another data point (the news is in the final paragraph):

I recently built two near-twin systems using Athlon 1.2's and VIA chipsets
(EPoX 8KTA3), and have *never* been able to get either to boot an
Athlon-optimized kernel, having tried 2.4.0, 2.4.2, 2.4.4, and about 5
different -ac* variants of 2.4.3.

They do boot PIII kernels reliably for all those variants, though they still
suffer occasional oopses, hangs, or crashes (as discussed in other threads).

However (and here's the part I haven't mentioned before), yesterday I switched
one of them to a new mb with a non-VIA chipset (Asus A7A266), and it booted the
first Athlon kernel I tried (2.4.4).  No other changes to .config, same
processor as before, same memory, same disks, same video, same case, same power
cord, you name it.

Bobby Bryant
Austin, Texas


