Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262895AbVCDMGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262895AbVCDMGV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 07:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbVCDLzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 06:55:08 -0500
Received: from cavan.codon.org.uk ([213.162.118.85]:29676 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S262906AbVCDLbG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 06:31:06 -0500
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050304112649.GQ1345@elf.ucw.cz>
References: <1109811404.5918.80.camel@tyrosine>
	 <20050304112649.GQ1345@elf.ucw.cz>
Date: Fri, 04 Mar 2005 11:30:57 +0000
Message-Id: <1109935857.5918.99.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: Re: Scheduling while atomic errors on swsusp resume
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-04 at 12:26 +0100, Pavel Machek wrote:

> Well, those are warnings, so it still works, right? Aha, "exited with
> preempt count 1" seems very wrong. Yes, please try this with
> vanilla. I'm running 2.6.11 with 

Yeah, the resume script crashes, which is a bit of a problem. I'll get
the user to try with a vanilla kernel, but I'm not having these problems
with an identical kernel - it seems to be something specific to his
setup.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

