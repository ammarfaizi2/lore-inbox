Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265014AbTFCNpy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 09:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265015AbTFCNpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 09:45:54 -0400
Received: from hoemail2.lucent.com ([192.11.226.163]:21909 "EHLO
	hoemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S265014AbTFCNpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 09:45:53 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16092.43423.958091.657360@gargle.gargle.HOWL>
Date: Tue, 3 Jun 2003 09:58:55 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: "John Stoffel" <stoffel@lucent.com>
Cc: Bernhard Rosenkraenzer <bero@arklinux.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 and 2.5.70-mm3 hang on bootup
In-Reply-To: <16090.48773.258921.532437@gargle.gargle.HOWL>
References: <Pine.LNX.4.53.0306011742490.3125@dot.kde.org>
	<16090.15708.707835.911577@gargle.gargle.HOWL>
	<16090.48773.258921.532437@gargle.gargle.HOWL>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just a followup on my problems getting 2.5.70-mm3 up and running on my
box.  Once I turned off ACPI in my config, I can now boot and run both
UP and SMP with APIC and IO-APIC running (my system actually needs
this) and I'm now running with the following:

      2.5.70-mm3, SMP, PREEMPT, RAID1

All seems ok so far, no major problems except getting ALSA to work
with my sound card again, but I haven't spent much time on it yet.
I've also gotten my Cyclom-Y/ISA multiport serial board working (see
the patch I sent out seperately) properly too.  

Thanks for all the help, my initial thoughts that APIC was the root of
my problem was wrong, it was all ACPI issues.  Maybe we should put in
a note in the Kconfig help entries for people to disable ACPI if they
enable SMP and/or UP APIC options?

John
