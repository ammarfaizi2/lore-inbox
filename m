Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270695AbTGNSkR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 14:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270697AbTGNSkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 14:40:17 -0400
Received: from smtp2.clear.net.nz ([203.97.37.27]:20098 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S270695AbTGNSkL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 14:40:11 -0400
Date: Tue, 15 Jul 2003 06:52:22 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [Swsusp-devel] Hotplug USB mouse bugs in 2.4+swsusp
In-reply-to: <200307110916.13785.EricAltendorf@orst.edu>
To: EricAltendorf@orst.edu
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>
Message-id: <1058208742.23914.20.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <200307110916.13785.EricAltendorf@orst.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-07-12 at 04:16, Eric Altendorf wrote:
> I'm running 2.4.21 (+ latest ACPI, toshiba ACPI, and swsusp pre14) and 
> to get my USB mouse working at all with swsusp I had to use hotplug.  
> However, I'm having a number of problems.
> 
> 3)
> After suspend & resume, USB mouse is gone.  Physically replugging it 
> doesn't help.  /etc/init.d/hotplug restart  fixes it.

That would imply issues with the hotplug driver what we could perhaps
fix using the recently added notifier chain. I'll look into it for you.
This chain was added after pre14, so you may already get some relief by
trying a newer version of swsusp.

Regards,

Nigel

-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

