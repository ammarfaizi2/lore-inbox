Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932575AbVLFNiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbVLFNiV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 08:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbVLFNh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 08:37:59 -0500
Received: from mail.enyo.de ([212.9.189.167]:16792 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S932575AbVLFNhu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 08:37:50 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de>
	<20051203205911.GX18919@marowsky-bree.de>
	<87wtij2iao.fsf@mid.deneb.enyo.de>
	<20051206132007.GU21914@marowsky-bree.de>
Date: Tue, 06 Dec 2005 14:37:46 +0100
In-Reply-To: <20051206132007.GU21914@marowsky-bree.de> (Lars Marowsky-Bree's
	message of "Tue, 6 Dec 2005 14:20:07 +0100")
Message-ID: <87lkyyqrbp.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lars Marowsky-Bree:

> On 2005-12-06T01:14:23, Florian Weimer <fw@deneb.enyo.de> wrote:
>
>> > The right way to address this is to work with the distribution of your
>> > choice to make these updates available faster.
>> Working with a distribution benefits that distribution alone.  Working
>> on (e.g.) kernel security advisories would benefit everyone.  It's not
>> a speed issue, it's more about coverage.  And full coverage is very
>> hard to get without support from the real developers.
>
> The distributions differ from another in their sync and branch points
> from the main kernel, and there's no way before hell freezes over this
> is going to change.
>
> So, you essentially need to maintain the kernel your distribution
> branched from. This means: backport fixes/features relevant to your
> release, and make sure the rest of the system stays in sync. This puts
> the effort there where it belongs: to those people benefitting from it.

Lars, please read again what I wrote.  It's not about branch
maintenance ("here's the patch"), it's about providing basic
information which can guide branch maintenance ("here's an issue you
need to look at if you use code from the IPv6 stack in version 2.6.10
to 2.6.12").
