Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVCSTM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVCSTM0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 14:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVCSTMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 14:12:25 -0500
Received: from waste.org ([216.27.176.166]:26053 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262662AbVCSTMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 14:12:12 -0500
Date: Sat, 19 Mar 2005 11:12:07 -0800
From: Matt Mackall <mpm@selenic.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc3: APM resume problems with USB
Message-ID: <20050319191207.GC32638@waste.org>
References: <423BF478.20305@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <423BF478.20305@goop.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2005 at 01:44:24AM -0800, Jeremy Fitzhardinge wrote:
> On my IBM ThinkPad X31, I can only do one successful APM resume.  After 
> the resume, there's a stream of messages on the console:
> 
> uhci_hcd 0000:00:1d.0: host controller process error, something bad 
> happened!
> uhci_hcd 0000:00:1d.0: host system error, PCI problems?
> uhci_hcd 0000:00:1d.0: host controller process error, something bad 
> happened!
> uhci_hcd 0000:00:1d.0: host system error, PCI problems?
> uhci_hcd 0000:00:1d.0: host controller process error, something bad 
> happened!
> uhci_hcd 0000:00:1d.0: host system error, PCI problems?
> uhci_hcd 0000:00:1d.0: host controller process error, something bad 
> happened!
> uhci_hcd 0000:00:1d.0: host system error, PCI problems?
> uhci_hcd 0000:00:1d.0: host controller process error, something bad 
> happened!
> uhci_hcd 0000:00:1d.0: host system error, PCI problems?
> uhci_hcd 0000:00:1d.0: host controller process error, something bad 
> happened!
> uhci_hcd 0000:00:1d.0: host system error, PCI problems?
> 
> 
> The second resume, the machine panics.  I haven't managed to get the 
> panic message yet.
> 
> This happens with both -rc3 and -rc4.

I think you mean -mm[34]. I've seen the problem with -mm3, 2.6.11{,.3}
seem to be fine. Also ACPI rather than APM is fine as well though the
suspend life is pathetic.

-- 
Mathematics is the supreme nostalgia of our time.
