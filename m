Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbUATDyy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 22:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbUATDyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 22:54:54 -0500
Received: from smtp3.adl2.internode.on.net ([203.16.214.203]:3599 "EHLO
	smtp3.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S262360AbUATDyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 22:54:53 -0500
Date: Tue, 20 Jan 2004 14:24:38 +1030
From: "Mark Williams (MWP)" <mwp@internode.on.net>
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TG3: very high CPU usage
Message-ID: <20040120035438.GA9123@linux.comp>
References: <fa.eu7l1gd.ekqe1j@ifi.uio.no> <bugf88$932$1@A8bba.a.pppool.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bugf88$932$1@A8bba.a.pppool.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Mark Williams (MWP) wrote:
> [...]
> >However, when using Apache or any FTP client/daemon, the TG3 driver 
> >appears to be VERY slow maxing out CPU usage at 100% while only 
> >transfering at around 12MB/sec.
> >This applies for both incoming or outgoing data.
> 
> [...]
> 
> >Ive tried other NICs, etc and confirmed that it is a problem with the TG3 
> >driver.
> 
> I saw the same problem with the bcm-driver (Kernel 2.4.x) shipped with
> SuSE 9 / SLES 8. Testcase was the initial mirror of a 10 GB partition on a
> raid5 serveraid / XSeries 235 (2 way) to the same hardware on the remote
> machine using both times the onboard NIC (Broadcom GBit Ethernet) via drbd:
> 100% CPU usage, 12 MB/s, machine is nearly death.

Well im glad someone else also has this problem.

Any of the TG3 maintainers have an idea as to whats causing it?

Im handy with C, but nowhere near good enough to go hacking away at the driver.
I would be happy to help test new drivers if needed.

Thanks.
