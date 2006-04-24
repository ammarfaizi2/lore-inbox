Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWDXIbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWDXIbj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 04:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWDXIbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 04:31:39 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18410 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750763AbWDXIbi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 04:31:38 -0400
Date: Mon, 24 Apr 2006 10:31:02 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: Martin Mares <mj@ucw.cz>, Matthew Garrett <mjg59@srcf.ucam.org>,
       "Yu, Luming" <luming.yu@intel.com>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Message-ID: <20060424083102.GE26345@elf.ucw.cz>
References: <554C5F4C5BA7384EB2B412FD46A3BAD1332980@pdsmsx411.ccr.corp.intel.com> <20060420073713.GA25735@srcf.ucam.org> <4447AA59.8010300@linux.intel.com> <20060420153848.GA29726@srcf.ucam.org> <4447AF4D.7030507@linux.intel.com> <mj+md-20060420.165714.18107.albireo@ucw.cz> <4447C020.3010003@linux.intel.com> <20060420220731.GF2352@ucw.cz> <444C761F.6010603@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <444C761F.6010603@linux.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 24-04-06 10:54:23, Alexey Starikovskiy wrote:
> Pavel Machek wrote:
> >>>I don't see any reason for treating some keys or buttons 
> >>>differently.
> >>>A key is just a key.
> >
> >>There is one special key anyway -- reset...
> >
> >Your point is? There's also hardware power button on many machines.
> >They are not controllable by software => they are not relevant to this
> >discussion.
> >
> Really? And you are what are you going to do with bugs about "my power 
> button doesn't remap, and always shuts down my machine?"

If they have hardware power button, I'll laugh at them (then
CLOSE/INVALID). Feel free to reassign such bugs to me.

Anyway stripping useful functinality because very old (386-era!)
machines don't support it is not a way to go.
								Pavel
-- 
Thanks for all the (sleeping) penguins.
