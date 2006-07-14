Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161171AbWGNQQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161171AbWGNQQb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 12:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161178AbWGNQQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 12:16:31 -0400
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:32689 "HELO
	smtp102.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161171AbWGNQQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 12:16:31 -0400
Date: Fri, 14 Jul 2006 09:16:28 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Daniel Drake <dsd@gentoo.org>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       greg@kroah.com, harmon@ksu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add SATA device to VIA IRQ quirk fixup list
Message-ID: <20060714161628.GB23918@tuatara.stupidest.org>
References: <20060714095233.5678A8B6253@zog.reactivated.net> <44B77B1A.6060502@garzik.org> <44B78294.1070308@gentoo.org> <44B78538.6030909@garzik.org> <20060714074305.1248b98e.akpm@osdl.org> <20060714154240.GA23480@tuatara.stupidest.org> <44B7C37F.1050400@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B7C37F.1050400@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2006 at 05:17:03PM +0100, Daniel Drake wrote:

> This suggests that the quirk is only needed for ACPI users, at least
> on that system.
>
> http://bugs.gentoo.org/show_bug.cgi?id=138036

Actually, the opposite is what I've seen and also had other people
claim.

VIA apparently when asked about this quirk (this wasn't by me, I have
no current contacts there and they've been very quiet here) responded
"use ACPI".

FWIW, I have very similar hardware to what's in the bug report and it
works w/ ACPI just fine.
