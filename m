Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265729AbUAKC40 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 21:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265732AbUAKC40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 21:56:26 -0500
Received: from uni01du.unity.ncsu.edu ([152.1.13.101]:16769 "EHLO
	uni01du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S265729AbUAKC4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 21:56:24 -0500
From: jlnance@unity.ncsu.edu
Date: Sat, 10 Jan 2004 21:56:23 -0500
To: linux-kernel@vger.kernel.org
Subject: Laptops & CPU frequency
Message-ID: <20040111025623.GA19890@ncsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
    I am running the 2.4 kernel (latest from Fedora) on a Thinkpad 600E
laptop.  If I start the laptop with the AC adapter turned on, the CPU
frequency in /proc/cpuinfo is approximatly 400 MHz.  However, if I start
the laptop on battery power, /proc/cpuinfo  indicates a processor frequency
of approximatly 100 MHz.
    The frequency displayed in /proc/cpuinfo does not change if the AC
adapter is toggled on or off after the machine has booted.  It stays
in the same mode as it was booted into.  I am curious if this is because
the CPU frequency really is not changing, or if it is because the
number in /proc/cpuinfo is only calculated at boot.


Thanks,

Jim
