Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263946AbRFEJ2K>; Tue, 5 Jun 2001 05:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263943AbRFEJ17>; Tue, 5 Jun 2001 05:27:59 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:33029 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S263264AbRFEJ1n>;
	Tue, 5 Jun 2001 05:27:43 -0400
Date: Mon, 4 Jun 2001 12:27:11 +0000
From: Pavel Machek <pavel@suse.cz>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: green@linuxhacker.ru, Alan Cox <laughing@shared-source.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac7
Message-ID: <20010604122708.B33@toy.ucw.cz>
In-Reply-To: <mailman.991555081.25242.linux-kernel2news@redhat.com> <200106032051.f53Kpgg10681@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200106032051.f53Kpgg10681@devserv.devel.redhat.com>; from zaitcev@redhat.com on Sun, Jun 03, 2001 at 04:51:42PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > How about ISA USB host controllers?
> 
> Those, unfortunately, do not exist. I was shopping for one
> in vain for a long time. One formiddable difficulty is that
> USB bandwidth is larger than ISA, so the only feasible way
> to make a HC is to have all TD's in its onboard memory,
> as in VGA.

USB is 1.2MB/sec while 8-bit ISA is 4MB/sec (memory-mapped).

...and OHCI does use board memory, anyway.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

