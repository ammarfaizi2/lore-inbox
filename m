Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbUBWQcJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 11:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbUBWQcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 11:32:09 -0500
Received: from ambr.mtholyoke.edu ([138.110.1.10]:42513 "EHLO
	ambr.mtholyoke.edu") by vger.kernel.org with ESMTP id S261942AbUBWQcF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 11:32:05 -0500
Date: Mon, 23 Feb 2004 11:32:04 -0500 (EST)
From: Ron Peterson <rpeterso@MtHolyoke.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: network / performance problems
In-Reply-To: <Pine.OSF.4.21.0402221620090.20455-100000@mhc.mtholyoke.edu>
Message-ID: <Pine.OSF.4.21.0402231122150.446245-100000@mhc.mtholyoke.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 22 Feb 2004, Ron Peterson wrote:

> I rebooted.  I set the BIOS to not run hyperthreaded, to see if that has
> any effect.  Now wait...

Turning hyperthreading off hasn't helped.  Ping response times are still
slowly increasing.

I just put up another set of graphs that might be the most interesting
yet.

http://depot.mtholyoke.edu:8080/tmp/depot-depot/2002-02-12_10.30/

They show depot, a very lightly used machine, monitoring itself, running
e1000, then being rebooted to use a new kernel with ACPI support, then
having the e1000 module swapped out for the bcm7500 module (switch back to
built in NIC).  Reboot brought response times down to almost
zero.  Switching module/NIC had no effect at all.

Does anyone have any ideas of things they'd like me to try?  My
imagination is running dry.  I have non-production 2650's and beige boxes
I can try stuff on.

_________________________
Ron Peterson
Network & Systems Manager
Mount Holyoke College

