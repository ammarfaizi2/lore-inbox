Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268155AbRGWIkz>; Mon, 23 Jul 2001 04:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268153AbRGWIkq>; Mon, 23 Jul 2001 04:40:46 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:7142 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S268151AbRGWIkn>; Mon, 23 Jul 2001 04:40:43 -0400
Message-ID: <3B5BE3EB.AE9A9293@veritas.com>
Date: Mon, 23 Jul 2001 14:14:27 +0530
From: "Amit S. Kale" <akale@veritas.com>
Organization: Veritas Software (India)
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
CC: "Michael S. Miles" <mmiles@alacritech.com>, linux-kernel@vger.kernel.org
Subject: Re: kgdb and/or kdb for RH7.1
In-Reply-To: <Pine.LNX.4.21.0107212015220.612-100000@penguin.homenet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

I am not maintaining a kgdb patch for RH7.1 as yet. This is an extact
from the newly uploaded FAQ page on kgdb website.

Why only one kernel version is supported? 
I enhance kgdb and add documentation to kgdb webpage frequently. This
process is easy with a single kernel version as I can work on
enhancing and supporting newer kernel versions at the same time. I
myself need kgdb for kernel debugging on newer kernels for the
translation filesystem. Supporting older kernels involves backporting
enhancements and testing them. Usually a kgdb patch works for
multiple kernel versions with a bit of application of failed hunks by
hand. I plan to support a fixed 2.4 kernel version and a top of the line
2.5
kernel, once 2.5 kernel branch starts. 


Tigran Aivazian wrote:
> 
> just in case you are wondering where to download kgdb from, there is one
> maintained at sourceforge by Amit Kale
> 
> http://kgdb.sourceforge.net/
> 
> On Sat, 21 Jul 2001, Michael S. Miles wrote:
> 
> > Does anyone know if patches exist against the stock RedHat 7.1
> > kernel(2.4.2-2) to support remote kernel debugging(kgdb).  I would also be
> > interested in the same for kdb, but I'm primarily interested in kgdb.
> >
> > If it doesn't exist I guess I will have to try to port the patches over
> > myself, I just didn't want to reinvent the wheel.
> >
> > hopefully TIA,
> > michael
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Amit Kale
Veritas Software ( http://www.veritas.com )
