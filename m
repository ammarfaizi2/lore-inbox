Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWGDTxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWGDTxo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 15:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWGDTxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 15:53:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47251 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932354AbWGDTxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 15:53:43 -0400
Date: Tue, 4 Jul 2006 15:53:34 -0400
From: Dave Jones <davej@redhat.com>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [Ubuntu PATCH] Add Dothan frequency tables for speedstep
Message-ID: <20060704195334.GD20952@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Lukas Hejtmanek <xhejtman@mail.muni.cz>,
	lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
References: <44A98250.6060508@oracle.com> <20060703214403.GP14292@redhat.com> <20060704191411.GA9787@mail.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060704191411.GA9787@mail.muni.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2006 at 09:14:11PM +0200, Lukas Hejtmanek wrote:
 > On Mon, Jul 03, 2006 at 05:44:03PM -0400, Dave Jones wrote:
 > > Yes it works great if your system is wired up to use VID#C,
 > > but what if it isn't ?  It's got a 1 in 4 chance of working,
 > > and what it'll do in the other 3 cases is anyones guess.
 > > 
 > > As there's no way to tell which VID is in use, the only
 > > option on these systems is to use either the acpi
 > > mode of this driver, or acpi-cpufreq instead.
 > 
 > Is this the same reason why this patch wasn't accepted in mainline?
 > http://fabrice.bellamy.club.fr/bdz.undervolt.2005.10.22.a.patch

No. That's was rejected due to the
"don't give people semi-automatic weapons to shoot their feet off with" principle.

The problem with patches like this, and the "let cpufreq overclock" patches,
and the "let me input my own voltage/freq pairs via sysfs" patches
is some lucky soul (yours truly) gets to deal with the fallout when peoples
computers crash after trying patches like this.   My inbox has more than enough
problems for me to dig into, without introducing more problems that are
frankly, undebuggable.

		Dave

-- 
http://www.codemonkey.org.uk
