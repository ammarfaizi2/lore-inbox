Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263479AbTK1WCG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 17:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbTK1WCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 17:02:06 -0500
Received: from vitelus.com ([64.81.243.207]:25568 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id S263479AbTK1WCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 17:02:04 -0500
Date: Fri, 28 Nov 2003 14:01:40 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Tell user when ACPI is killing machine
Message-ID: <20031128220140.GB1714@vitelus.com>
References: <20031128145558.GA576@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031128145558.GA576@elf.ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 28, 2003 at 03:55:58PM +0100, Pavel Machek wrote:
> On critical overheat (or perceived critical overheat -- acpi bioses on
> some notebooks apparently report bogus values from time to time),
> kernel itself calls /sbin/halt *without telling anything*. User can
> not see anything, his machine just shuts down cleanly. Bad.

Sorry if this is a bit OT, but why doesn't ACPI scale the CPU
frequency back instead of shutting down? This is what APM does on my
laptop (presumably in the BIOS) but when I enable ACPI the machine
shuts down whenever I do something CPU intensive (yes; it's a poorly
designed laptop). I have cpufreq support (cpufreq: P4/Xeon(TM) CPU
On-Demand Clock Modulation available). Has this kind of thing been
added since I last tried it, or do I actually have to actively set up
cpufreq in user space to get thermally-induced clock modulation? Or is
not even possible with the current state of things?
