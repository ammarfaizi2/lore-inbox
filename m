Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752020AbWJWVkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbWJWVkX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 17:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752023AbWJWVkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 17:40:23 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:38602 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1752020AbWJWVkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 17:40:22 -0400
Date: Mon, 23 Oct 2006 22:39:44 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, rjw@sisk.pl, ncunningham@linuxmail.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Message-ID: <20061023213943.GA21361@srcf.ucam.org>
References: <1161576735.3466.7.camel@nigel.suspend2.net> <200610231236.54317.rjw@sisk.pl> <1161605379.3315.23.camel@nigel.suspend2.net> <200610231607.17525.rjw@sisk.pl> <20061023095522.e837ad89.akpm@osdl.org> <20061023171450.GA3766@elf.ucw.cz> <20061023105022.8b1dc75d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061023105022.8b1dc75d.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 10:50:22AM -0700, Andrew Morton wrote:

> Apparently uswsusp has gained support for S3 while the in-kernel driver
> does not support S3.  That's disappointing.

I'm still not sure why that's an especially desirable feature. Every 
laptop I've played with will automatically resume from S3 when the 
battery level becomes critical, which gives you the opportunity to 
suspend to disk. And when it doesn't, you can generally emulate it using 
the ACPI alarm to wake up. Is there really a significant quantity of 
hardware out there that doesn't support either of these?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
