Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVABF56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVABF56 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 00:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVABF56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 00:57:58 -0500
Received: from orb.pobox.com ([207.8.226.5]:25812 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261164AbVABF55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 00:57:57 -0500
Date: Sat, 1 Jan 2005 21:57:53 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: John M Flinchbaugh <john@hjsoft.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10: e100 network broken after swsusp/resume
Message-ID: <20050102055753.GB7406@ip68-4-98-123.oc.oc.cox.net>
References: <20041228144741.GA2969@butterfly.hjsoft.com> <20050101172344.GA1355@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050101172344.GA1355@elf.ucw.cz>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 01, 2005 at 06:23:44PM +0100, Pavel Machek wrote:
> e100 seems to have some suspend/resume support [but if even reloading
> e100 does not help, fault is not in e100]. Are you running with APIC
> enabled? Try noapic. Try acpi=off.

Reloading doesn't help, with either e100 or 8139too. I forgot to mention
that in my other e-mail in this thread. (As I previously mentioned, on
my system with 8139too, noapic makes matters worse, and the problem goes
away if I use *either* pci=routeirq or acpi=off. I haven't tried using
both.)

-Barry K. Nathan <barryn@pobox.com>

