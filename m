Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbUCRMs6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 07:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUCRMs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 07:48:58 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:6118 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262596AbUCRMs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 07:48:57 -0500
Date: Thu, 18 Mar 2004 13:48:56 +0100
From: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
To: Matthew Reppert <repp0017@umn.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SCSI emulation - CD-R
Message-ID: <20040318124856.GB28402@atrey.karlin.mff.cuni.cz>
References: <200403172109.i2HL9RcP007960@qix.software.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403172109.i2HL9RcP007960@qix.software.umn.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The first time I had to set up a CD writer to work with Linux, I checked
> (what is now) the Linux Documentation Project http://www.tldp.org/ which
> has a nice CD-writer HOWTO document, detailing not only how you need to
> configure your kernel, but also how to use the userspace tools to burn
> CDs.
> 
> However, with recent kernels and tools, you don't need to (and shouldn't)
> use ide-scsi to use ATAPI CD writers. cdrecord dev=/dev/hdc (assuming
> that's
> the correct IDE device) works just fine.

Now it works. The trick was to disable the support for ATAPI CD-ROM

Cl<
