Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbTIJLNQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 07:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTIJLNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 07:13:16 -0400
Received: from luli.rootdir.de ([213.133.108.222]:51886 "HELO luli.rootdir.de")
	by vger.kernel.org with SMTP id S261977AbTIJLNP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 07:13:15 -0400
Date: Wed, 10 Sep 2003 13:13:12 +0200
From: Claas Langbehn <claas@rootdir.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew de Quincey <adq@lidskialf.net>, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] [2.6.0-test5-mm1] Suspend to RAM problems
Message-ID: <20030910111312.GA847@rootdir.de>
References: <20030910103142.GA1053@rootdir.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910103142.GA1053@rootdir.de>
Reply-By: Sa Sep 13 13:10:31 CEST 2003
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.0-test4-mm4 i686
X-No-archive: yes
X-Uptime: 13:10:31 up 2 min,  1 user,  load average: 0.13, 0.12, 0.05
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also tried to suspend with ACPI in single user mode:

echo 3 >/proc/acpi/sleep

makes the system sleep within a second.

After waking it up by pressing a key or the power button
the VGA Bios shows up for a second and afterwards I get
this message:

APIC error on CPU0: 08(08)

...and it repeats endlessly :(

my keyboard is dead afterwards.

