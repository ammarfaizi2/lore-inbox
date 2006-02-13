Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751676AbWBMJZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbWBMJZw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 04:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbWBMJZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 04:25:52 -0500
Received: from cantor2.suse.de ([195.135.220.15]:28560 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751676AbWBMJZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 04:25:51 -0500
From: Andi Kleen <ak@suse.de>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: 2.6.16-rc2, x86-64, CPU hotplug failure
Date: Mon, 13 Feb 2006 10:18:06 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
References: <200602130230.41120.s0348365@sms.ed.ac.uk>
In-Reply-To: <200602130230.41120.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602131018.06549.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 February 2006 03:30, Alistair John Strachan wrote:
> Hi,
> 
> In an attempt to play with ACPI S3 on my Athlon 64 X2 3800+, I recompiled 
> 2.6.16-rc2 with CPU hotplug and ACPI sleep state support. I experienced 
> multiple crashes and oopsen, which I quickly discovered were the result of 
> bringing at least one CPU back online.

Yes, known problem. They seem to be related to the powernow driver. Does
it work if you don't compile CPUFREQ in?

-Andi
