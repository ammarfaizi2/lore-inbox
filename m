Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130916AbRBWUhB>; Fri, 23 Feb 2001 15:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129849AbRBWUUs>; Fri, 23 Feb 2001 15:20:48 -0500
Received: from xanadu.kublai.com ([166.84.169.10]:896 "HELO xanadu.kublai.com")
	by vger.kernel.org with SMTP id <S129193AbRBWUU3>;
	Fri, 23 Feb 2001 15:20:29 -0500
Date: Fri, 23 Feb 2001 15:20:29 -0500
From: Brendan Cully <brendan@kublai.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: regular lockup on 2.4.2 (w/oops)
Message-ID: <20010223152029.A384@xanadu.kublai.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010223143458.A596@xanadu.kublai.com> <E14WOF1-0006yd-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <E14WOF1-0006yd-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Feb 23, 2001 at 07:50:57PM +0000
X-Operating-System: Linux 2.4.2 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 23 February 2001 at 19:50, Alan Cox wrote:
> > I wonder if it's related to ACPI and/or IDE - I seem to get on
> > occasion one ide_dmaproc: lost interrupt message during fsck - after a
> > few seconds it recovers only to hang for good some 10-15 seconds
> > later.
> 
> Turn off ACPI and try that kernel. If that one also causes problems then it
> helps a lot as it implies its not ACPI. If it works then its ACPI and most
> of us will be happy (except Andrew of course)

Preliminary results indicate ACPI was the culprit. I brought up my
system a couple times and SysRq-S,B'd, forcing full fsck's of all my
filesystems. With ACPI enabled I never got through all of them, now
everything appears ok. Will let you know if the problem reoccurs.

Thanks,
Brendan
