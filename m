Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbTFHAyF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 20:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264173AbTFHAyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 20:54:05 -0400
Received: from fe1.rdc-kc.rr.com ([24.94.163.48]:35847 "EHLO mail1.kc.rr.com")
	by vger.kernel.org with ESMTP id S264153AbTFHAyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 20:54:04 -0400
Date: Sat, 7 Jun 2003 20:07:40 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: lost interrupts with 2.4.1-rc6 and i875p chipset
Message-ID: <20030608010739.GA1889@glitch.localdomain>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030603111519.GA23228@glitch.localdomain> <20030607192008.GA3345@jhereg.dmeyer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030607192008.GA3345@jhereg.dmeyer.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 07, 2003 at 03:20:08PM -0400, dmeyer@dmeyer.net wrote:
> Followup to this:  with 2.4.21-rc7-ac1, I get very different
> behavior.  If I boot with noapic, my machine goes into an endless loop
> of
> 
>    APIC error on CPU0: 40(40)
> 
> errors.  If I boot regularly (APIC enabled), everything is fine.  My
> machine has been up for almost a full day without a single lost
> interrupt message.  This, BTW, is with ACPI enabled in both cases.

It looks like -ac1 works for me with apic enabled as well.  I haven't
tried rebooting with noapic yet,,,
