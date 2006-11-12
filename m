Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752041AbWKLS3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbWKLS3w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 13:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752301AbWKLS3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 13:29:52 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:37345 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1752041AbWKLS3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 13:29:51 -0500
Date: Sun, 12 Nov 2006 10:25:54 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Burman Yan <yan_952@hotmail.com>, trivial@kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATH] Replace kmalloc+memset with kzalloc 1/17
Message-Id: <20061112102554.c9d422b7.randy.dunlap@oracle.com>
In-Reply-To: <20061112173103.GA14005@flint.arm.linux.org.uk>
References: <BAY20-F1803D00EDD5FC1FD65726ED8F50@phx.gbl>
	<20061112173103.GA14005@flint.arm.linux.org.uk>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Nov 2006 17:31:03 +0000 Russell King wrote:

> On Sun, Nov 12, 2006 at 07:20:53PM +0200, Burman Yan wrote:
> > This is the first part of the patches I made that do trivial change of 
> > replacing
> > kmalloc and memset with kzalloc
> 
> Please follow the guidelines in SubmittingPatches in the kernel source
> when sending patches out.  You must not expect everyone here to read
> each of the attachments in your messages in detail to work out whether
> they need to do something with it or not.

You should also use a different subject for each one,
something that is related to the subsystem being patched,
e.g., [PATCH] scsi: use kzalloc

Besides Documentation/SubmittingPatches, please also read
http://linux.yyz.us/patch-format.html
and http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt

---
~Randy
