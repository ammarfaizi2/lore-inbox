Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265149AbUAaTjr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 14:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265155AbUAaTjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 14:39:47 -0500
Received: from sitemail3.everyone.net ([216.200.145.37]:61132 "EHLO
	omta06.mta.everyone.net") by vger.kernel.org with ESMTP
	id S265149AbUAaTjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 14:39:46 -0500
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
Date: Sat, 31 Jan 2004 11:39:45 -0800 (PST)
From: john moser <bluefoxicy@linux.net>
To: linux-kernel@vger.kernel.org
Subject: ACPI -- Workaround for broken DSDT
Reply-To: bluefoxicy@linux.net
X-Originating-Ip: [68.33.187.247]
Message-Id: <20040131193945.955BF7261@sitemail.everyone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC me all replies.


http://abaababa.ouvaton.org/presario/

Please note that a recompiled and fixed DSDT table exists for the Compaq Presario
2100 series.  I would like to be able to simply point my kernel at this file at
compile time from a configuration menu, and compile it in to the kernel.  I can
probably find the DSDT load code myself, but compiling external data into a
program and accessing it is something foreign to me (IDE's like Borland C++ Builder
did it for you and so I never was able to learn how with GCC).

This may be useful in the future for broken ACPI.  Could someone please make a
quick patch to allow the path of a DSDT table to be defined so that it may be
compiled into the kernel and override the ACPI DSDT table in the BIOS?  I'll
peek around, but ACPI and this sort of programming isn't my strong point.

If anyone is familiar with this area and would be willing to write up a patch,
please CC me so I don't spend days/weeks trying to figure out how the heck to
do this ;)



_____________________________________________________________
Linux.Net -->Open Source to everyone
Powered by Linare Corporation
http://www.linare.com/
