Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129929AbRBEUXz>; Mon, 5 Feb 2001 15:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135508AbRBEUXq>; Mon, 5 Feb 2001 15:23:46 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:32526 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129929AbRBEUXl>;
	Mon, 5 Feb 2001 15:23:41 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Andreas Dilger <adilger@turbolinux.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: modversions.h source pollution in 2.4 
In-Reply-To: Your message of "Mon, 05 Feb 2001 11:16:50 PDT."
             <200102051816.f15IGoT11015@webber.adilger.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 06 Feb 2001 07:23:25 +1100
Message-ID: <2287.981404605@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Feb 2001 11:16:50 -0700 (MST), 
Andreas Dilger <adilger@turbolinux.com> wrote:
>Keith Owens writes:
>> Maintainers: please fix these sources by removing modversions.h.
>
>It is not clear from your posting if anything other than removing the
>"#include <linux/modversions.h>" line is needed...  Also, what kernel
>versions is this needed for?  The LVM code uses a common source file
>for 2.2 and 2.4, so should the #include stay in for 2.2?

It should be as simple as removing #include <linux/modversions.h>, and
it applies to all kernels, back to 2.1.81.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
