Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280081AbRKEAon>; Sun, 4 Nov 2001 19:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280084AbRKEAo0>; Sun, 4 Nov 2001 19:44:26 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:51985 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S280081AbRKEAoL>;
	Sun, 4 Nov 2001 19:44:11 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200111050044.fA50i8o182130@saturn.cs.uml.edu>
Subject: Re: The PCI ID Repository
To: mj@ucw.cz (Martin Mares)
Date: Sun, 4 Nov 2001 19:44:08 -0500 (EST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <20011104170202.A3370@ucw.cz> from "Martin Mares" at Nov 04, 2001 05:02:02 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares writes:

> The repository lives at http://pciids.sourceforge.net/ and you can download

What about revision codes?

Vendor and device really isn't enough to identify something.
There may be completely different chips with the same vendor
and device IDs.

Tundra provides an example: Universe, Universe II, Universe IIB

These chips are the same device in some sense; they are all
PCI-to-VME bridges. (damn popular too) The programming interface
is incompatible, so they get different revisions. Tundra isn't
alone in interpreting the PCI spec this way.



