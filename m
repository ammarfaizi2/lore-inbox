Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbUCQKAV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 05:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbUCQKAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 05:00:21 -0500
Received: from hell.org.pl ([212.244.218.42]:8200 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S261248AbUCQKAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 05:00:19 -0500
Date: Wed, 17 Mar 2004 11:00:15 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       john stultz <johnstul@us.ibm.com>, Dominik Brodowski <linux@brodo.de>,
       acpi-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] X86_PM_TIMER: /proc/cpuinfo doesn't get updated
Message-ID: <20040317100015.GA19994@hell.org.pl>
Mail-Followup-To: Peter Chubb <peter@chubb.wattle.id.au>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	john stultz <johnstul@us.ibm.com>,
	Dominik Brodowski <linux@brodo.de>,
	acpi-devel@lists.sourceforge.net,
	lkml <linux-kernel@vger.kernel.org>
References: <481113193@toto.iv> <16471.43776.178128.198317@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <16471.43776.178128.198317@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Peter Chubb:
> >> Hmm... without the patch, neither cpu MHz nor bogomips are updated,
> >> with the patch cpu MHz value seems correct (both using acpi.ko and
> >> speedstep-ich.ko, but the bogomips is still at its initial value.
> Dmitry> Karol, do you have a P4? AFAIK P4's TSC is stable even if core
> Dmitry> frequence changes so loop_per_juffy (== bogomips) need not be
> Dmitry> updated.
> The TSC is variable rate for Pentium-IV if you're using clock
> modulation.

Yes, the machine in question does have a P4-M. Note also that the ACPI
throttling interface (processor.ko, I believe) doesn't update the bogomips
either.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
