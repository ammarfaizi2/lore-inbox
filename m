Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316113AbSFYTg2>; Tue, 25 Jun 2002 15:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316158AbSFYTg1>; Tue, 25 Jun 2002 15:36:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10764 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316113AbSFYTg0>;
	Tue, 25 Jun 2002 15:36:26 -0400
Message-ID: <3D18C5E4.B7423294@zip.com.au>
Date: Tue, 25 Jun 2002 12:35:00 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Miles Lane <miles@megapathdsl.net>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Automatically mount or remount EXT3 partitions with EXT2 when 
 alaptop is powered by a battery?
References: <3D18A273.284F8EDD@zip.com.au> <1025025852.1519.54.camel@turbulence.megapathdsl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
> 
> ..
> > If it's because of the disk-spins-up-too-much problem then
> > that can be addressed by allowing the commit interval to be
> > set to larger values.
> 
> Thanks Andrew,
> 
> Yes, the concern is the syncing every few seconds.
> Would it be possible and make sense to have this
> setting get adjusted dynamically when a laptop goes
> onto battery power?

If the APM/ACPI stuff can report the transition to userspace then yes,
that's something which their support scripts could do.

-
