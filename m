Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130243AbRBZPwE>; Mon, 26 Feb 2001 10:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130245AbRBZPvz>; Mon, 26 Feb 2001 10:51:55 -0500
Received: from dfw-smtpout1.email.verio.net ([129.250.36.41]:24525 "EHLO
	dfw-smtpout1.email.verio.net") by vger.kernel.org with ESMTP
	id <S130243AbRBZPvk>; Mon, 26 Feb 2001 10:51:40 -0500
Message-ID: <3A9A7B89.CA1A7D97@bigfoot.com>
Date: Mon, 26 Feb 2001 07:51:37 -0800
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.19pre8+IDE i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
Subject: Re: "clock timer configuration lost" error?
In-Reply-To: <E14XP60-0001KO-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Interesting.  This is a KA7 with all power management turned off in the
latest Abit BIOS.

> The kernel puts the timer back and life appears happy again

Ahhh.  The kernel *is* god.


Alan Cox wrote:
> 
> > Feb 26 00:19:52 abit kernel: probable hardware bug: clock timer
> > configuration lost - probably a VIA686a.
> > Feb 26 00:19:52 abit kernel: probable hardware bug: restoring chip
> > configuration.
> > Feb 26 00:26:53 abit xntpd[886]: synchronized to 132.239.254.5,
> > stratum=2
> > ...
> 
> Small number of VIA 686 boxes randomly jump from 100Hz back to the DOS 18Hz
> timeout. We dont know if its hardware or maybe APM bios bugs. The kernel puts
> the timer back and life appears happy again

--
