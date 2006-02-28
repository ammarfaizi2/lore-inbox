Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932616AbWB1XyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932616AbWB1XyM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 18:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbWB1XyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 18:54:12 -0500
Received: from ns2.suse.de ([195.135.220.15]:49367 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932616AbWB1XyK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 18:54:10 -0500
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Cc: Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: AMD64 X2 lost ticks on PM timer
References: <200602280022.40769.darkray@ic3man.com>
	<20060227222152.GA26541@ti64.telemetry-investments.com>
	<Pine.LNX.4.61.0602271744270.31386@dhcp83-105.boston.redhat.com>
	<200602281041.27960.darkray@ic3man.com>
	<20060228220054.GC23330@ti64.telemetry-investments.com>
From: Andi Kleen <ak@suse.de>
Date: 01 Mar 2006 00:53:58 +0100
In-Reply-To: <20060228220054.GC23330@ti64.telemetry-investments.com>
Message-ID: <p73veuzyr8p.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bill Rugolsky Jr." <brugolsky@telemetry-investments.com> writes:
> 
> The machine is running PostgreSQL, so the Lost tick messages occur
> throughout the day, but they come frequently during our nightly cron
> jobs that do rsyncs, checksums, etc. So far today:

What chipset?

> I got another test machine up and running today, so I can start patching and
> testing tomorrow.

What output do you get when you run ftp.suse.com:/pub/people/ak/tools/trtc.c ?
(and what is the _HZ value you configured in Kconfig?)

Does it go away when you run with idle=poll?

-Andi
