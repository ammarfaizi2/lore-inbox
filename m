Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292231AbSCONHe>; Fri, 15 Mar 2002 08:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292229AbSCONHY>; Fri, 15 Mar 2002 08:07:24 -0500
Received: from kim.it.uu.se ([130.238.12.178]:36337 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S292270AbSCONHJ>;
	Fri, 15 Mar 2002 08:07:09 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15505.61940.536141.204015@kim.it.uu.se>
Date: Fri, 15 Mar 2002 14:07:00 +0100
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IO-APIC -- lockup on machine if enabled
In-Reply-To: <20020315100502.GA12793@merlin.emma.line.org>
In-Reply-To: <200203132052.VAA08581@harpo.it.uu.se>
	<20020315100502.GA12793@merlin.emma.line.org>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree writes:
 > On Wed, 13 Mar 2002, Mikael Pettersson wrote:
 > 
 > > p.s. The update for 2.4.19-pre3 and the full kit for 2.4.18 are
 > > at <http://www.csd.uu.se/~mikpe/linux/patches/2.4/> as usual.
 > 
 > Does that also fix the "crashes on switch back from X11 to text (or
 > frame buffer) console" that's been around since 2.4.9 or 2.4.10, but not
 > before, that bites so many users of SuSE Linux 7.3?
 > de.comp.os.unix.linux.* has at least one report every week. SuSE shipped
 > kernel 2.4.10 with 7.3.

The dmi-apic-fixups patch ONLY deals with disabling use of the local
APIC (or parts of it in some cases, e.g. AL440LX) when a known broken
BIOS or machine is detected by the DMI scan.

Without an adequate analysis of the problem you describe above I can't
even guess what the fix might be.

/Mikael
