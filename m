Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbULGACt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbULGACt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 19:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbULGACt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 19:02:49 -0500
Received: from orb.pobox.com ([207.8.226.5]:4326 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261697AbULGACp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 19:02:45 -0500
Date: Mon, 6 Dec 2004 16:02:36 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3 - no interrupt 10 after swsusp unless pci=routeirq used
Message-ID: <20041207000236.GA4118@ip68-4-98-123.oc.oc.cox.net>
References: <1102374645.13483.3.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102374645.13483.3.camel@tyrosine>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2004 at 11:10:45PM +0000, Matthew Garrett wrote:
> Using 2.6.10-rc3, I get no network activity after swsusp resume. USB
> devices also fail to work. On checking /proc/interrupts, interrupt 10
> (which they share) is no longer being incremented. Adding pci=routeirq
> to the boot flags makes it work.

This sounds like a problem I'm seeing with 2.6.10-rc2-bk12 (I don't
recall seeing it with a patched Red Hat/Fedora 2.6.9-1.681_FC3 kernel).
However, I need to test things again and pay more attention before I can
say for sure that it's the same problem (hopefully I'll have time next
week).

-Barry K. Nathan <barryn@pobox.com>

