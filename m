Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129446AbRCHTa6>; Thu, 8 Mar 2001 14:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129466AbRCHTas>; Thu, 8 Mar 2001 14:30:48 -0500
Received: from gnu.in-berlin.de ([192.109.42.4]:53771 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S129446AbRCHTag>;
	Thu, 8 Mar 2001 14:30:36 -0500
X-Envelope-From: news@goldbach.in-berlin.de
To: linux-kernel@vger.kernel.org
Path: kraxel
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: Process memory DMA access from devices, kiobuf ?
Date: 8 Mar 2001 18:53:28 GMT
Organization: Strusel 007
Message-ID: <slrn9afl98.10g.kraxel@bogomips.masq.in-berlin.de>
In-Reply-To: <3AA74F31.554A7A42@beam.demon.co.uk>
NNTP-Posting-Host: bogomips.masq.in-berlin.de
X-Trace: goldbach.masq.in-berlin.de 984077608 7789 192.168.69.77 (8 Mar 2001 18:53:28 GMT)
X-Complaints-To: news@goldbach.in-berlin.de
NNTP-Posting-Date: 8 Mar 2001 18:53:28 GMT
User-Agent: slrn/0.9.6.3 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Barnaby wrote:
> Hi,
> 
> We are doing work with FPGA's and have a Linux driver for a particular
> board that has these
> devices. For performance reasons the driver has the ability to DMA
> directly to process (user)
> memory. We have made use of the kiobuf routines such as
> "map_user_kiobuf()" to map into
> physical memory the user address space.
> I note that the RedHat kernels have a patched kernel containing the
> kiobuf code but the
> standard linux source does not right up to 2.4.2.

Huh?  map_user_kiobuf() _is_ present in 2.4.2.  See include/linux/iobuf.h

  Gerd

-- 
Get back there in front of the computer NOW. Christmas can wait.
	-- Linus "the Grinch" Torvalds,  24 Dec 2000 on linux-kernel
