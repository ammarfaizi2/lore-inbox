Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWFZPrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWFZPrR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 11:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWFZPrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 11:47:17 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:46513 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1750716AbWFZPrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 11:47:16 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       suspend2-devel@lists.suspend2.net
Subject: Suspend2 - Request for review & inclusion in -mm
Date: Tue, 27 Jun 2006 01:47:16 +1000
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200606270147.16501.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I'd like, at long last, to submit Suspend2 for review and inclusion in -mm.

All going well, I'll shortly be sending a number of sets of patches, which 
together represent the whole of suspend2 as it stands at the moment. Those of 
you who've looked at Suspend2 code before will see that there are far fewer 
changes outside of kernel/power than there have been in the past. In some 
cases, this is because we were early adopters of some functionality that has 
now been merged, and in others because better, less intrusive ways have been 
found of doing some things.

Some of the advantages of suspend2 over swsusp and uswsusp are:

- Speed (Asynchronous I/O and readahead for synchronous I/O)
- Well tested in a wide range of configurations
- Supports multiple swap partitions and files
- Supports writing to ordinary files and raw devices.
- Userspace helpers for user interface and storage management.
- Support for cancelling the suspend at any point while the image is being 
written (can be disabled)
- Can be configured and reconfigured without rebooting.
- Scripting support

I'm very much part-time on this, so please accept my apologies in advance if 
I'm slow in replying to responses.

A git tree is now available on kernel.org:

http://www.kernel.org/git/?p=linux/kernel/git/nigelc/suspend2-2.6.git;a=summary

Regards,

Nigel
-- 
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia
