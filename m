Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbTIPNVp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 09:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbTIPNVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 09:21:45 -0400
Received: from yonge.cs.toronto.edu ([128.100.1.8]:46487 "HELO
	yonge.cs.toronto.edu") by vger.kernel.org with SMTP id S261879AbTIPNVm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 09:21:42 -0400
Date: Tue, 16 Sep 2003 09:15:10 -0400
From: Behdad Esfahbod <behdad@cs.toronto.edu>
X-X-Sender: behdad@dvp.cs
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test5 problems with DHCP and Synaptics
Message-ID: <Pine.GSO.4.44.0309160910260.14235-100000@dvp.cs>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[please keep me CCed in replies]

Hi all,

Since I have upgraded to test5, I'm facing two problems:

	* ifup eth0 with DHCP hangs the machine times to times if
there's no link available.  Other times, ifdown eth0 would not
respond and cannot be killed.  I never had this problem with
previous 2.6s.

	* I just started using Synaptics patch and Synaptics
driver for XFree86.  I have read the synaptics patches carefully
and they are not doing anything wrote, so the problem should be
in the kernel itself.  The problem is that, when booting up, my
Synaptics would be detected if the USB mouse is not plugged!  and
would be recognized as a generic PS/2 mouse if the USB mouse is
plugged!  I have tried for around 10 times, and this is the exact
case.  Any ideas?

Thanks,
behdad

