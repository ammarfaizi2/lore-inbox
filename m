Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131393AbQLJSVG>; Sun, 10 Dec 2000 13:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131535AbQLJSUr>; Sun, 10 Dec 2000 13:20:47 -0500
Received: from usc.edu ([128.125.253.136]:32233 "EHLO usc.edu")
	by vger.kernel.org with ESMTP id <S131393AbQLJSUj>;
	Sun, 10 Dec 2000 13:20:39 -0500
Date: Sun, 10 Dec 2000 09:50:11 -0800 (PST)
From: Ryan Barnett <rbarnett@usc.edu>
To: linux-kernel@vger.kernel.org
Subject: Got "VM: do_try_to_free_pages failed for xyz" in 2.2.18pre27
Message-ID: <Pine.GSO.4.21.0012100943380.19986-100000@aludra.usc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is notice that the do_try_to_free_pages bug is still present in the
latest 2.2 kernel, 2.2.18pre27.

VM: do_try_to_free_pages failed for kjournald...
VM: do_try_to_free_pages failed for kjournald...
VM: do_try_to_free_pages failed for kjournald...

The error also occurs for other processes running on the system.  This was
a test with ext3.

The bug triggers when the system is really hammered (high system, network,
and disk load), and requires a reboot to recover.

Ryan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
