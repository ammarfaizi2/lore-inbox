Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423127AbWJYIix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423127AbWJYIix (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 04:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423132AbWJYIiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 04:38:52 -0400
Received: from dev.mellanox.co.il ([194.90.237.44]:913 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S1423123AbWJYIiv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 04:38:51 -0400
Date: Wed, 25 Oct 2006 10:37:11 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Pavel Machek <pavel@suse.cz>
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       len.brown@intel.com, linux-acpi@vger.kernel.org, linux-pm@osdl.org,
       jgarzik@pobox.com, linux-ide@vger.kernel.org
Subject: Re: 2.6.19-rc2: known unfixed regressions (v3)
Message-ID: <20061025083711.GB9518@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20061025082820.GD7083@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061025082820.GD7083@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Pavel Machek <pavel@suse.cz>:
> > >
> > > Subject    : T60 stops triggering any ACPI events
> > > References : http://lkml.org/lkml/2006/10/4/425
> > >              http://lkml.org/lkml/2006/10/16/262
> > > Submitter  : "Michael S. Tsirkin" <mst@mellanox.co.il>
> > > Status     : unknown
> > 
> > Just retested with 2.6.19-rc3 - it's still there:
> > e.g. after I do a full kernel compile, my T60 stops triggering any ACPI events:
> > tail -f /var/log/acpid does not show anything, even on Fn/F4 which is supposed
> > to be always enabled.  Restarting the acpid doesn't do anything either - ACPI
> > starts working again, for a while, only after reboot.
> > 
> > Works fine in 2.6.18 ( + this patch http://lkml.org/lkml/2006/7/20/56).
> 
> Bugzilla.kernel.org, assign it to acpi people...

Already done, http://bugzilla.kernel.org/show_bug.cgi?id=7408

-- 
MST
