Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbTL1OgL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 09:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTL1OgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 09:36:11 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:1288 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261500AbTL1OgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 09:36:09 -0500
Date: Sun, 28 Dec 2003 14:36:03 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Pat Gefre <pfg@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Updating our sn code in 2.6
Message-ID: <20031228143603.A20391@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pat Gefre <pfg@sgi.com>, akpm@osdl.org, davidm@napali.hpl.hp.com,
	linux-kernel@vger.kernel.org
References: <20031220122749.A5223@infradead.org> <Pine.SGI.3.96.1031222204757.20064A-100000@fsgi900.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.SGI.3.96.1031222204757.20064A-100000@fsgi900.americas.sgi.com>; from pfg@sgi.com on Mon, Dec 22, 2003 at 08:55:10PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 08:55:10PM -0600, Pat Gefre wrote:
> + issues before merging, it's not that much anyway..
> 
> I think I did. I sent another email with the changes I made for the
> issues you raised - and updated the patches. If I missed any, please
> let me know.

Looking at oss.sgi.com/projects/sn2/sn2-update:

 - no change in 000-hwgfs-update.patch.inprogress, hwgraph_path_lookup
   shall not be reintroduced.
 - 014-cleanup-pci.c.patch:  no change apparently?
 - 030-pciio-cleanup.patch: Dito
 - 071-xswitch.devfunc.patch: Dito.
 - 075-rename-reorg.patch: Dito


> David or Andrew can you take these patches ?

Really, that's not what I consider fixing.  Please fix up
000,014 and 030 and drop 071 and 075, then it should be fine for
merging.  071 shouldn't go in at all and 075 needs the renaming killed,
everything else can go in although it's not nice.

