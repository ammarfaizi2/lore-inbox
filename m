Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWILJTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWILJTE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 05:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965145AbWILJTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 05:19:03 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:24743 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750991AbWILJTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 05:19:02 -0400
Date: Tue, 12 Sep 2006 11:19:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: [PATCH] - restore i8259A eoi status on resume
Message-ID: <20060912091906.GB19482@elf.ucw.cz>
References: <20060910141533.GA6594@srcf.ucam.org> <200609110746.58548.ak@suse.de> <20060911110530.GA15320@srcf.ucam.org> <200609112202.50756.ak@suse.de> <20060911222351.GA23679@srcf.ucam.org> <20060911230745.GA24001@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060911230745.GA24001@srcf.ucam.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Got it. i8259A_resume calls init_8259A(0) unconditionally, even if 
> auto_eoi has been set. Keep track of the current status and restore that 
> on resume. This fixes it for AMD64 and i386.

Patch looks okay to me...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
