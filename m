Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130448AbRCWJxA>; Fri, 23 Mar 2001 04:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130454AbRCWJwu>; Fri, 23 Mar 2001 04:52:50 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:45836 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130448AbRCWJwe>; Fri, 23 Mar 2001 04:52:34 -0500
Subject: Re: Incorrect mdelay() results on Power Managed Machines x86
To: sfr@canb.auug.org.au
Date: Fri, 23 Mar 2001 09:54:21 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, twoller@crystal.cirrus.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <200103230400.f2N40xk15331@pcug.org.au> from "sfr@canb.auug.org.au" at Mar 23, 2001 03:00:59 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14gOH2-0004Mm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On the ThinkPad 600E (at least), we get a Power Status Change APM event.

Any reason we couldn't recalibrate the bogomips on a power status change,
at least for laptops we know appear to need it (I can make the DMI code look
for matches there..)
