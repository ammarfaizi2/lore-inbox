Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265116AbTL3VX2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 16:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265802AbTL3VX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 16:23:27 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:56462 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S265116AbTL3VX0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 16:23:26 -0500
Date: Tue, 30 Dec 2003 15:21:13 -0600 (CST)
From: Pat Gefre <pfg@sgi.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Pat Gefre <pfg@sgi.com>, akpm@osdl.org, davidm@napali.hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Updating our sn code in 2.6
In-Reply-To: <20031228143603.A20391@infradead.org>
Message-ID: <Pine.SGI.3.96.1031230151441.2502941C-100000@daisy-e236.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Dec 2003, Christoph Hellwig wrote:

+ On Mon, Dec 22, 2003 at 08:55:10PM -0600, Pat Gefre wrote:
+ > + issues before merging, it's not that much anyway..
+ > 
+ > I think I did. I sent another email with the changes I made for the
+ > issues you raised - and updated the patches. If I missed any, please
+ > let me know.
+ 
+ Looking at oss.sgi.com/projects/sn2/sn2-update:
+ 
+  - no change in 000-hwgfs-update.patch.inprogress, hwgraph_path_lookup
+    shall not be reintroduced.
+  - 014-cleanup-pci.c.patch:  no change apparently?
+  - 030-pciio-cleanup.patch: Dito
+  - 071-xswitch.devfunc.patch: Dito.
+  - 075-rename-reorg.patch: Dito
+ 
+ 
+ > David or Andrew can you take these patches ?
+ 
+ Really, that's not what I consider fixing.  Please fix up
+ 000,014 and 030 and drop 071 and 075, then it should be fine for
+ merging.  071 shouldn't go in at all and 075 needs the renaming killed,
+ everything else can go in although it's not nice.
+ 

I've been out of town, so haven't responded to this yet.

I'll remove hwgraph_path_lookup() from 000, remove snia64_pci_find_bios()
from 014 and remove pcibr_businfo_get() from 030.

I'll drop 071. So I can assume that if I get rid of the renaming in 075
you are OK with that ?



