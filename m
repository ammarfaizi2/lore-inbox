Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945931AbWBOMvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945931AbWBOMvy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 07:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945932AbWBOMvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 07:51:54 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:58294 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1945931AbWBOMvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 07:51:53 -0500
Date: Wed, 15 Feb 2006 12:47:29 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Thomas Renninger <trenn@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>,
       Stefan Seyfried <seife@suse.de>, linux-pm@lists.osdl.org,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] [1/3] Generic in-kernel AC status
Message-ID: <20060215124729.GA10968@srcf.ucam.org>
References: <20060208125753.GA25562@srcf.ucam.org> <20060210121913.GA4974@elf.ucw.cz> <43F216FE.7050101@suse.de> <200602142117.31232.rjw@sisk.pl> <43F3206B.6090902@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F3206B.6090902@suse.de>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 01:36:59PM +0100, Thomas Renninger wrote:

> Maybe I oversaw an issue, but I really don't see a reason for connecting
> the brightness to ac in kernel space.

The backlight class maintainer specified that /sys/../brightness should 
return the *current* brightness. In some cases that's impossible without 
knowing the ac status.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
