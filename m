Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAXUWY>; Wed, 24 Jan 2001 15:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129745AbRAXUWP>; Wed, 24 Jan 2001 15:22:15 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:26119 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S129444AbRAXUWE>; Wed, 24 Jan 2001 15:22:04 -0500
Date: Wed, 24 Jan 2001 21:19:48 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Mahadev K Cholachagudda <mahadev_kc@yahoo.com>
Cc: linux-kernel@vger.kernel.org, crossgcc@sources.redhat.com,
        gcc-help@gcc.gnu.org
Subject: Re: Why only Linux uses GCC to compile the source code. please help
Message-ID: <20010124211947.E1417@arthur.ubicom.tudelft.nl>
In-Reply-To: <000b01c08608$427a8540$2e00a8c0@kcmahadev>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000b01c08608$427a8540$2e00a8c0@kcmahadev>; from mahadev_kc@yahoo.com on Wed, Jan 24, 2001 at 06:49:13PM +0530
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 24, 2001 at 06:49:13PM +0530, Mahadev K Cholachagudda wrote:
> The problems if one uses 'x' compiler other than GCC.
> =====================================================
> 
> 1. He/she may not get the features of GCC listed above into the 'x'
> compiler.
> 
> 2. The Linux kernel mainly uses GCC. If the Linux kernel is made to compile
> using 'x' compiler other than GCC, then code updation will take time for 'x'
> compiler if a newer version or patch of Linux released.

I see no problems over here. Linux makes explicit use of GCC features,
it was not meant to be compiled with a different compiler. Note that
the Linux kernel is not a normal program, so we don't have to deal with
compatibility. If you want to use another compiler to compile your
kernel: go ahead, but don't expect any help from this list.

> 3. The Linux code may have some code which is purely based upon the data
> types e.g. for one processor the unsigned long may be 32 bits or 16 bits.

That's what the __uXX/__sXX data types are for: to ensure that the data
types are indeed XX bits long. See include/asm-*/types.h.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
