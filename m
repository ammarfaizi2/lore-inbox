Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261465AbUKLRo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbUKLRo7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 12:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbUKLRo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 12:44:59 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:15815 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261465AbUKLRoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 12:44:19 -0500
Date: Fri, 12 Nov 2004 18:42:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Len Brown <len.brown@intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: [BKPATCH] ACPI for 2.6
Message-ID: <20041112174248.GA4267@openzaurus.ucw.cz>
References: <1099986428.6090.53.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099986428.6090.53.camel@d845pe>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> <len.brown@intel.com> (04/11/05 1.1803.163.1)
>    [ACPI] Allow limiting idle C-States.
>    
>    Useful to workaround C3 ipw2100 packet loss,
>    reducing noise or boot issues on some models.
>    http://bugme.osdl.org/show_bug.cgi?id=3549
>    
>    For static processor driver, boot cmdline:
>    processor.acpi_cstate_limit=2

You certainly win "ugliest parameter of the month" contest :-).

What about processor.max_cstate= or something?


> <len.brown@intel.com> (04/10/18 1.1803.119.24)
>    [ACPI] add module parameters: processor.c2=[0,1] processor.c3=[0,1]
>    to disable/enable C2 or C3
>    blacklist entries for R40e and Medion 41700

So we have two independend ways to disable C states?
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

