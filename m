Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314656AbSEBRFu>; Thu, 2 May 2002 13:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314657AbSEBRFt>; Thu, 2 May 2002 13:05:49 -0400
Received: from numenor.qualcomm.com ([129.46.51.58]:12002 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S314656AbSEBRFt>; Thu, 2 May 2002 13:05:49 -0400
Message-Id: <5.1.0.14.2.20020502100227.0f15f9a0@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 02 May 2002 10:04:50 -0700
To: Adrian Bunk <bunk@fs.tum.de>, Dave Jones <davej@suse.de>
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: Re: Linux 2.5.12-dj1
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.NEB.4.40.0205021248290.14217-100000@mimas.fachschafte
 n.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >...
> > o   Bluetooth update.                         (Maksim (Max) Krasnyanskiy)
> >...
>
>"dev_list" is now defined in two files and I got the following compile
>error when building a kernel with all Bluetooth drivers compiled
>statically into the kernel:
You probably don't want to compile all _cs.o modules into the kernel.
But it's a bug in any case. dev_list should be static.  I'll fix that.

Thanks
Max

