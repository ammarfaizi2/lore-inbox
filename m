Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265045AbTFCPRr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 11:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265046AbTFCPRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 11:17:47 -0400
Received: from hoemail2.lucent.com ([192.11.226.163]:38072 "EHLO
	hoemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S265045AbTFCPRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 11:17:46 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16092.48937.452212.3930@gargle.gargle.HOWL>
Date: Tue, 3 Jun 2003 11:30:49 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: Bernhard Rosenkraenzer <bero@arklinux.org>,
       KML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.70 and 2.5.70-mm3 hang on bootup
In-Reply-To: <1054651654.5268.64.camel@workshop.saharacpt.lan>
References: <Pine.LNX.4.53.0306011742490.3125@dot.kde.org>
	<16090.15708.707835.911577@gargle.gargle.HOWL>
	<16090.48773.258921.532437@gargle.gargle.HOWL>
	<16092.43423.958091.657360@gargle.gargle.HOWL>
	<1054651654.5268.64.camel@workshop.saharacpt.lan>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin> On Tue, 2003-06-03 at 15:58, John Stoffel wrote:
>> Thanks for all the help, my initial thoughts that APIC was the root of
>> my problem was wrong, it was all ACPI issues.  Maybe we should put in
>> a note in the Kconfig help entries for people to disable ACPI if they
>> enable SMP and/or UP APIC options?
>> 

Martin> Both my previous board (Asus P4T533-C with 850E chipset) and
Martin> current one (Asus P4C800 with 875P chipset) works fine with
Martin> ACPI, APIC, and IO-APIC enabled ....

You have much newer chipsets that I do, I have a 440GX board.  My
suggestion for the note in Kconfig is merely that if your system hangs
after printing just a couple of lines on bootup, try disabling ACPI in
your kernel.

I probably wasn't clear enough.

John
