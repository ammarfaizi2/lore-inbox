Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLFRBv>; Wed, 6 Dec 2000 12:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129348AbQLFRBl>; Wed, 6 Dec 2000 12:01:41 -0500
Received: from collibf1.jhuapl.edu ([128.244.27.248]:2743 "EHLO
	collibf1.jhuapl.edu") by vger.kernel.org with ESMTP
	id <S129257AbQLFRBa>; Wed, 6 Dec 2000 12:01:30 -0500
Message-ID: <3A2E69DA.661A9994@jhuapl.edu>
Date: Wed, 06 Dec 2000 11:31:22 -0500
From: Skip Collins <bernard.collins@jhuapl.edu>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: system hang and corrupt ext2 filesystem with test12-pre5
In-Reply-To: <3A2E51B0.76C65771@jhuapl.edu> <3A2E5FAA.FF29E9D7@Hell.WH8.TU-Dresden.De>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Udo A. Steinberg" wrote:

> What drive are you using? AFAIR, Andre Hedrick once said certain Maxtor
> drives aren't quite safe with DMA.

Using an IBM 45GB udma5 capable drive. The problems only occur under
_heavy_ disk activity.  I have -d 1 -c 3 -m 16 set.

Have you tried thrashing your drive for an extended time? Try repeatedly
copying more than one GB file simultaneously.

Perhaps this is not relevant, but I have only run into the problem when
manipulating vmware virtual disk files in some way, both inside and
outside of vmware itself. This is probably because these are the only
large files I have dealt with since installing a 2.4 kernel. But could
some aspect of the structure of these files, such as large holes, be
triggering the corruption?

sc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
