Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422656AbWHLUX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422656AbWHLUX1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 16:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422661AbWHLUX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 16:23:27 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57478 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422656AbWHLUX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 16:23:26 -0400
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: wim@iguana.be, linux-kernel@vger.kernel.org,
       Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <200608121945.52202.thomas.koeller@baslerweb.com>
References: <200608102319.13679.thomas@koeller.dyndns.org>
	 <1155326835.24077.116.camel@localhost.localdomain>
	 <200608121945.52202.thomas.koeller@baslerweb.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 12 Aug 2006 21:43:41 +0100
Message-Id: <1155415422.24077.131.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-08-12 am 19:45 +0200, ysgrifennodd Thomas Koeller:
> On Friday 11 August 2006 22:07, Alan Cox wrote:
> > Also if this is a software watchdog why is it better than using
> > softdog ?
> >
> 
> This is _not_ a software watchdog. If the timer expires, an interrupt
> is generated, and the timer is reset to count through another cycle.
> If it expires again, it resets the CPU.

Ok thanks, then it does make sense for it to be in kernel.

