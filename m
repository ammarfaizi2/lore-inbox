Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267079AbSK2PHI>; Fri, 29 Nov 2002 10:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267081AbSK2PHH>; Fri, 29 Nov 2002 10:07:07 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:25990 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267079AbSK2PHH>;
	Fri, 29 Nov 2002 10:07:07 -0500
Date: Fri, 29 Nov 2002 15:11:45 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Daniel Nofftz <nofftz@castor.Uni-Trier.DE>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, alan@redhat.com
Subject: Re: A new Athlon 'bug'.
Message-ID: <20021129151145.GC20166@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Daniel Nofftz <nofftz@castor.Uni-Trier.DE>,
	Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com, alan@redhat.com
References: <20021126194129.GA24152@suse.de> <Pine.LNX.4.44.0211291554330.30552-100000@hades.uni-trier.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211291554330.30552-100000@hades.uni-trier.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2002 at 04:08:32PM +0100, Daniel Nofftz wrote:

 > maybe somone remembers that i hacked a little bit with the power saving
 > modes of the athlon processor. so far as i know, the clk_ctl register is
 > importand when the athlon processor comes back from acpi-c2 mode. in c2 he
 > is disconnected from the system bus and the internal clock is clocked
 > down. in some cases a false value in this register could prevent the
 > athlon processor to come back from c2 -> lockup of the machine or
 > something like it ...

Correct. It contains values that indicate to the CPU how to ramp up
the CPU clock during low-power modes.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
