Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130228AbRBZO5L>; Mon, 26 Feb 2001 09:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130165AbRBZO4h>; Mon, 26 Feb 2001 09:56:37 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61190 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130212AbRBZOyb>; Mon, 26 Feb 2001 09:54:31 -0500
Subject: Re: "clock timer configuration lost" error?
To: timothymoore@bigfoot.com (Tim Moore)
Date: Mon, 26 Feb 2001 14:57:47 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (kernel)
In-Reply-To: <3A9A1F5B.AF529C8F@bigfoot.com> from "Tim Moore" at Feb 26, 2001 01:18:19 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14XP60-0001KO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Feb 26 00:19:52 abit kernel: probable hardware bug: clock timer
> configuration lost - probably a VIA686a. 
> Feb 26 00:19:52 abit kernel: probable hardware bug: restoring chip
> configuration. 
> Feb 26 00:26:53 abit xntpd[886]: synchronized to 132.239.254.5,
> stratum=2
> ...
> 
> Anyone have a clue about the 'probable hdw bug' messages?  No disk
> activity to speak of, no other symptoms and/or messages.

Small number of VIA 686 boxes randomly jump from 100Hz back to the DOS 18Hz
timeout. We dont know if its hardware or maybe APM bios bugs. The kernel puts
the timer back and life appears happy again

