Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292826AbSB0THq>; Wed, 27 Feb 2002 14:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289299AbSB0THT>; Wed, 27 Feb 2002 14:07:19 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:56841
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S292894AbSB0TG4>; Wed, 27 Feb 2002 14:06:56 -0500
Date: Wed, 27 Feb 2002 10:53:41 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Jan Niehusmann <jan@gondor.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: IDE error on 2.4.17
In-Reply-To: <20020227184758.GA9260@gondor.com>
Message-ID: <Pine.LNX.4.10.10202271052360.19407-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Did you enable smart?
Did you run the captive smart tests?

If this is on you / drive DO NOT run captive mode, the kernel go into
starvation mode.

On Wed, 27 Feb 2002, Jan Niehusmann wrote:

> On Wed, Feb 27, 2002 at 02:59:28PM +0000, Alan Cox wrote:
> > This is the wrong approach. That information is available properly if and
> > when the vendors install the smart utilities
> 
> Doesn't necessarily help. I recently saw a hard drive which made funny
> noises and got really slow reading some parts of the drive (~30MB/s on
> some parts, ~300kB/s on others), but ide-smart didn't report failed
> tests. Two days later the drive was dead...
> 
> It was an IBM 60GB drive, but I don't remember the exact type. It
> called itself "IC35L060AVER07-0".
> 
> Jan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

