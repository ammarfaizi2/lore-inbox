Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965106AbVIANrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965106AbVIANrD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 09:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965109AbVIANrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 09:47:03 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:52152 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S965106AbVIANrA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 09:47:00 -0400
X-ORBL: [67.117.73.34]
Date: Thu, 1 Sep 2005 16:46:34 +0300
From: Tony Lindgren <tony@atomide.com>
To: Con Kolivas <kernel@kolivas.org>, vatsa@in.ibm.com,
       linux-kernel@vger.kernel.org, arjan@infradead.org,
       s0348365@sms.ed.ac.uk, tytso@mit.edu, cfriesen@nortel.com,
       rlrevell@joe-job.com, trenn@suse.de, george@mvista.com,
       johnstul@us.ibm.com, akpm@osdl.org
Subject: Re: Updated dynamic tick patches
Message-ID: <20050901134634.GE10677@atomide.com>
References: <20050831165843.GA4974@in.ibm.com> <200509011523.13994.kernel@kolivas.org> <20050901130721.GB10677@atomide.com> <20050901131915.GL5011@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050901131915.GL5011@khan.acc.umu.se>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* David Weinehall <tao@acc.umu.se> [050901 16:19]:
> On Thu, Sep 01, 2005 at 04:07:22PM +0300, Tony Lindgren wrote:
> [snip]
> > I tried this quickly on a loaner ThinkPad T30, and needed the following
> > patch to compile. The patch does work with PIT, but with lapic the
> > system does not wake to timer interrupts :(
> 
> That may be a thinkpad issue; I have to boot my Thinkpad with nolapic.

Yeah, that could be. Or it could be the same old P4 does not wake to
APIC interrupt while P3 does bug :)

Tony
