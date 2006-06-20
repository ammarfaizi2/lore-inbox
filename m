Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWFTFNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWFTFNx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 01:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWFTFNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 01:13:53 -0400
Received: from xenotime.net ([66.160.160.81]:43669 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751223AbWFTFNw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 01:13:52 -0400
Date: Mon, 19 Jun 2006 22:16:39 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: blp@cs.stanford.edu, bcollins@ubuntu.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Ubuntu PATCH] acpi: Add IBM R60E laptop to proc-idle blacklist
Message-Id: <20060619221639.3adbbf34.rdunlap@xenotime.net>
In-Reply-To: <87lkrstrgy.fsf@benpfaff.org>
References: <4491BC6B.5000704@oracle.com>
	<20060619203333.5e897ead.akpm@osdl.org>
	<87lkrstrgy.fsf@benpfaff.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006 20:51:09 -0700 Ben Pfaff wrote:

> Andrew Morton <akpm@osdl.org> writes:
> 
> > On Thu, 15 Jun 2006 13:00:43 -0700
> > Randy Dunlap <randy.dunlap@oracle.com> wrote:
> >
> >> [UBUNTU:acpi] Add IBM R60E laptop to proc-idle blacklist.
> 
> >> +	{ set_max_cstate, "IBM ThinkPad R40e", {
> >> +	  DMI_MATCH(DMI_BIOS_VENDOR, "IBM"),
> >> +	  DMI_MATCH(DMI_BIOS_VERSION, "1SET70WW") }, (void*)1},
> >
> > It seems that every R40e in the world is in that table.
> 
> The email says R60e.
> The string says R40e.
> Which is correct?

Good question for Ben.  Ben??

Current ubuntu-dapper git is still like this.

---
~Randy
