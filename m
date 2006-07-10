Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422770AbWGJTCQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422770AbWGJTCQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 15:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422774AbWGJTCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 15:02:16 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:51983 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1422770AbWGJTCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 15:02:15 -0400
Date: Mon, 10 Jul 2006 15:02:14 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Brown, Len" <len.brown@intel.com>
cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       <johnstul@us.ibm.com>, <linux-pm@lists.osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: RE: [linux-pm] [BUG] sleeping function called from invalid context
 during resume
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6ED003F@hdsmsx411.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.44L0.0607101452310.5721-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006, Brown, Len wrote:

> oops, looks like I e-mailed and attached a diff that was
> from before I built and tested.  The version in git
> has one line different -- includes actypes.h as you suggest.
> I've updated the attachment in the bug report above to match git.
> 
> note that the definitions of acpi_cpu_flags
> and acpi_thread_id are not un-needed.  Indeed,
> they must occur in aclinux.h above where actypes.h
> is included or the ACPICA defaults would be used
> and that would break the Linux build.

Thank you.  Additional comments added to the bug report (#3469).

Alan Stern

