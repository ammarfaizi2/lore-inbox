Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131301AbRCHJWm>; Thu, 8 Mar 2001 04:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131304AbRCHJWd>; Thu, 8 Mar 2001 04:22:33 -0500
Received: from finch-post-12.mail.demon.net ([194.217.242.41]:32013 "EHLO
	finch-post-12.mail.demon.net") by vger.kernel.org with ESMTP
	id <S131301AbRCHJWY>; Thu, 8 Mar 2001 04:22:24 -0500
Message-ID: <3AA74F31.554A7A42@beam.demon.co.uk>
Date: Thu, 08 Mar 2001 09:21:53 +0000
From: Terry Barnaby <terry@beam.demon.co.uk>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22enterprise i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Process memory DMA access from devices, kiobuf ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are doing work with FPGA's and have a Linux driver for a particular
board that has these
devices. For performance reasons the driver has the ability to DMA
directly to process (user)
memory. We have made use of the kiobuf routines such as
"map_user_kiobuf()" to map into
physical memory the user address space.
I note that the RedHat kernels have a patched kernel containing the
kiobuf code but the
standard linux source does not right up to 2.4.2.
Is there a better recommended way to perform DMA access to user memory
from a device
using the Linux kernel ?

Cheers

Terry

--
  Dr Terry Barnaby                     BEAM Ltd
  Phone: +44 1454 324512               Northavon Business Center, Dean Rd
  Fax:   +44 1454 313172               Yate, Bristol, BS37 5NH, UK
  Email: terry@beam.demon.co.uk        Web: www.beam.demon.co.uk
  BEAM for: Visually Impaired X-Terminals, Parallel Processing, Software Dev
                         "Tandems are twice the fun !"



