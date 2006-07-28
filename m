Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWG1Ag1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWG1Ag1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 20:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWG1Ag0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 20:36:26 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:43661 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932071AbWG1AgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 20:36:25 -0400
Date: Fri, 28 Jul 2006 01:36:15 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, "Brown, Len" <len.brown@intel.com>,
       Pavel Machek <pavel@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
Subject: Re: Generic battery interface
Message-ID: <20060728003615.GA23477@srcf.ucam.org>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com> <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com> <20060727232427.GA4907@suse.cz> <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 03:27:00AM +0300, Shem Multinymous wrote:

> Yes, I know -- tp_smapi does that too. And it's still negligible,
> usually a few microseconds.

With ACPI "smart" batteries, we're currently spending long enough on 
querying batteries that people are losing keystrokes. The same is true 
of several crummy APM implementations. On the other hand, I agree that 
it makes sense to leave polling in userspace rather than the kernel. 
Once we go tickless on portable hardware, there's going to be a pretty 
huge incentive to fix userspace in any case.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
