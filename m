Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131145AbRAVWVe>; Mon, 22 Jan 2001 17:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130536AbRAVWVQ>; Mon, 22 Jan 2001 17:21:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58124 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131096AbRAVWU5>;
	Mon, 22 Jan 2001 17:20:57 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101222150.f0MLodd01769@flint.arm.linux.org.uk>
Subject: Re: Proper OOPS report
To: hstokset@privat.cybercity.no (Henrik Stokseth)
Date: Mon, 22 Jan 2001 21:50:38 +0000 (GMT)
Cc: freyason@yahoo.com (Tom), linux-kernel@vger.kernel.org
In-Reply-To: <003701c08481$2461a300$27f8423e@avenger> from "Henrik Stokseth" at Jan 22, 2001 03:39:35 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henrik Stokseth writes:
> you were the one with the gcc 2.95.3 compiler right? even though this
> compiler is a prerelease of a stable branch i have confirmed errors in the
> optimalization passes. my advice: use a compiler which really IS stable
> (gcc-2.95.2 or egcs-1.1.2 are fine), or turn off all optimalizations.

The Linux kernel relies on having optimisation turned on (think of all
those inline functions).

(I don't think this rule has changed, has it?)

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
