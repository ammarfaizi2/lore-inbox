Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161130AbWGNPmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161130AbWGNPmu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 11:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161131AbWGNPmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 11:42:50 -0400
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:19050 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161130AbWGNPmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 11:42:49 -0400
Date: Fri, 14 Jul 2006 08:42:40 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, greg@kroah.com, harmon@ksu.edu,
       linux-kernel@vger.kernel.org, Daniel Drake <dsd@gentoo.org>
Subject: Re: [PATCH] Add SATA device to VIA IRQ quirk fixup list
Message-ID: <20060714154240.GA23480@tuatara.stupidest.org>
References: <20060714095233.5678A8B6253@zog.reactivated.net> <44B77B1A.6060502@garzik.org> <44B78294.1070308@gentoo.org> <44B78538.6030909@garzik.org> <20060714074305.1248b98e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060714074305.1248b98e.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2006 at 07:43:05AM -0700, Andrew Morton wrote:

> How do we fix all this?  (Who owns it?)

If someone who has this problem with ACPI is enabled can verify that
Windows works that would be helpful, then we might be able to figure
out why CONFIG_ACPI=y doesn't suffice for *some* people.  I've been
told that VIA got their ACPI wrong in some cases so that might be why
it doesn't work --- but if Windows deals with it we might be able to
do whatever windows does in this case.

Doing the quick blindly as we did before (and current -mm does) breaks
for some people and trying to list all the IDs breaks for others
(apparently a larger or certainly louder group).
