Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311582AbSDBMGR>; Tue, 2 Apr 2002 07:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311587AbSDBMGL>; Tue, 2 Apr 2002 07:06:11 -0500
Received: from kim.it.uu.se ([130.238.12.178]:28404 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S311582AbSDBMGC>;
	Tue, 2 Apr 2002 07:06:02 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15529.40615.727233.96629@kim.it.uu.se>
Date: Tue, 2 Apr 2002 14:05:59 +0200
To: linux-kernel@vger.kernel.org
Subject: early PCI detection?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a known incompatibility between AMD 76x northbridges and
VIA southbridges which makes IO-APIC mode unreliable.
(See AMD's errata sheets for details.)

The question is: can the Linux kernel run PCI detection before
IO-APIC initialisation, so as to prevent IO-APIC mode on mainboards
using this configuration?

Alternatively we could list known problem boards in the DMI blacklist
table, but this is clearly an inferior solution.

/Mikael
