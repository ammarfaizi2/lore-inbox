Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281947AbRKUSr6>; Wed, 21 Nov 2001 13:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281944AbRKUSrs>; Wed, 21 Nov 2001 13:47:48 -0500
Received: from [194.102.114.109] ([194.102.114.109]:58753 "EHLO
	linux.dec.com.ro") by vger.kernel.org with ESMTP id <S281943AbRKUSrn>;
	Wed, 21 Nov 2001 13:47:43 -0500
Date: Wed, 21 Nov 2001 20:48:51 +0200 (EET)
From: Kovacs Andrei <andik@dec.com.ro>
To: <linux-kernel@vger.kernel.org>
Subject: bug in free or in kernel ?
Message-ID: <Pine.LNX.4.33.0111212039380.2004-100000@linux.dec.com.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have just installed the 2.4.14 kernel and I see some strange values showed
by free:

             total       used       free     shared    buffers     cached
Mem:        254816     250620       4196          0       2068     165208
-/+ buffers/cache:      83344     171472
Swap:       262544      63264     199280

The system has been working for 2 hours and it is in X.
If I know well... if the buffers are smaller than "- buffers", here 83 mb,
then the system doesn't work optimally. That shouldn't be a problem but with
the 2.4.14 kernel I don't see it growing over 5 mb. I tried adjusting the
buffermem parameters in /proc/sys/vm/buffermem but it doesn't exist anymore. I
looked in the patches and I saw it has been removed since 2.4.10, but I
couldn't find the reason for this there or on the mailing list archives. Also,
the freepages file is missing.
The system is a P III at 800 MHz and under the 2.4.7 and 2.4.9 kernels all was
fine.
Also when I try to tar or untar some files, from time to time the system locks
up for about 2 or 3 seconds. That didn't happen under 2.4.9.

Thanx

-- 
Kovacs Andrei,
Network Manager - Digital Electronic Petrosani
E-mail: andik@dec.com.ro
Phone: +40-93-226563

