Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264359AbUANT05 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 14:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263609AbUANTYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 14:24:30 -0500
Received: from relay.pair.com ([209.68.1.20]:2828 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S263893AbUANTXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 14:23:30 -0500
X-pair-Authenticated: 68.42.66.6
Subject: Re: Laptops & CPU frequency
From: Daniel Gryniewicz <dang@fprintf.net>
To: Robert Love <rml@ximian.com>
Cc: Dave Jones <davej@redhat.com>,
       Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1074107842.1153.959.camel@localhost>
References: <20040111025623.GA19890@ncsu.edu>
	 <20040111025623.GA19890@ncsu.edu> <1073791061.1663.77.camel@localhost>
	 <E1Afj2b-0004QN-00@chiark.greenend.org.uk>
	 <E1Afj2b-0004QN-00@chiark.greenend.org.uk>
	 <1073841200.1153.0.camel@localhost>
	 <E1AfjdT-0008OH-00@chiark.greenend.org.uk>
	 <1073843690.1153.12.camel@localhost>  <20040114045945.GB23845@redhat.com>
	 <1074107508.4549.10.camel@localhost>  <1074107842.1153.959.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1074108207.5935.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 14 Jan 2004 14:23:27 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-01-14 at 14:17, Robert Love wrote:
> Dave did not mean that the other power management schemes cannot do the
> automatic reduction on loss of AC, just that there is no SMM/BIOS hacks
> to do it automatically.
> 
> Your APM scripts are probably adjusting your CPU speed when you go on
> AC.  Fedora does this, for example.

No APM scripts, no APM even.  I have ACPI, but no acpid, and I don't
currently do anything with ACPI other than get battery status and
temperature.  It also happened before I built in any cpufreq support.

> That is cool - the OS (user-space, even) controls the policy.
> 
> What we don't like is how SpeedStep can be controlled from SMM.

This happens even booted into DOS, so it's definitely a BIOS thing.  I
haven't looked into turning it off, I can check next time I reboot.
-- 
Daniel Gryniewicz <dang@fprintf.net>
