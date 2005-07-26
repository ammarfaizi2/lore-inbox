Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbVGZO4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVGZO4d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 10:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVGZOyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 10:54:08 -0400
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:32687 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261826AbVGZOxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 10:53:38 -0400
Date: Tue, 26 Jul 2005 16:53:32 +0200
From: Voluspa <lista1@telia.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3 Battery times at 100/250/1000 Hz = Zero difference
Message-Id: <20050726165332.022f5a02.lista1@telia.com>
In-Reply-To: <20050726131439.GB2134@ucw.cz>
References: <20050721200448.5c4a2ea0.lista1@telia.com>
	<20050726131439.GB2134@ucw.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2005 15:14:39 +0200 Vojtech Pavlik wrote:
> This almost looks like a regular Athlon 64, not even the mobile
> version. I wouldn't expect very big deep sleep capabilities on that
> one. You can check the 
> 
> 	/proc/acpi/processor/CPU1/power
> 
> file for the list of C states. A normal Athlon64 will likely have only
> C0. Mobile chips can go up to C4, which is really deep sleep.

You've probably already seen that /proc/acpi/processor/CPU1/power lists
C1 only here. Ok, with your input regarding normal CPUs I'm inclined
to believe ACPI is correct in my case. Still, I'll learn/read the code.
Always have had a need to finish those long marches.

Mvh
Mats Johannesson
--
