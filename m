Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267163AbSLQVbM>; Tue, 17 Dec 2002 16:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267164AbSLQVbM>; Tue, 17 Dec 2002 16:31:12 -0500
Received: from fmr01.intel.com ([192.55.52.18]:20429 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267163AbSLQVbK>;
	Tue, 17 Dec 2002 16:31:10 -0500
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A5B1@orsmsx119.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Ducrot Bruno'" <poup@poupinou.org>, linux-kernel@vger.kernel.org
Cc: Pavel Machek <pavel@suse.cz>, acpi-devel@lists.sourceforge.net
Subject: RE: [PATCH] S4bios for 2.5.52.
Date: Tue, 17 Dec 2002 13:39:02 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Ducrot Bruno [mailto:poup@poupinou.org] 
> This patch add s4bios support for 2.5.52.
> 
> S4bios is an alternative for the ACPI S4 system suspend 
> state, but is a bit
> more easy to implement.  It suppose though that the BIOS 
> support this feature.
> For some BIOS, creating a so-called suspend partition with the help
> of lphdisk is OK.
> 
> Plus, it permit for Pavel to have a nice graphic display at 
> suspend/resume. 
> 
> echo 4 > /proc/acpi/sleep is for swsusp;
> echo 4b > /proc/acpi/sleep is for s4bios.

I still am not clear on why we would want s4bios in 2.5.x, since we have S4.
Like you said, S4bios is easier to implement, but since Pavel has done much
of the heavy lifting required for S4 proper, I don't see the need.

Regards -- Andy
