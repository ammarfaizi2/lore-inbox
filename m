Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264902AbTLWC4X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 21:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264916AbTLWC4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 21:56:23 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:10177 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S264902AbTLWC4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 21:56:21 -0500
Date: Mon, 22 Dec 2003 20:55:10 -0600 (CST)
From: Pat Gefre <pfg@sgi.com>
To: Christoph Hellwig <hch@infradead.org>
cc: Pat Gefre <pfg@sgi.com>, akpm@osdl.org, davidm@napali.hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Updating our sn code in 2.6
In-Reply-To: <20031220122749.A5223@infradead.org>
Message-ID: <Pine.SGI.3.96.1031222204757.20064A-100000@fsgi900.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Dec 2003, Christoph Hellwig wrote:

+ On Fri, Dec 19, 2003 at 07:05:05PM -0800, Jesse Barnes wrote:
+ > Andrew, I'm ok with these patches (and it looks like Christoph doesn't
+ > find them too repulsive either) and David said he'd rather have you take
+ > them directly if they look ok.  Will you merge them into your tree
+ > please?  Like I said, this gets the tree into a very good state for
+ > people using Altix machines, and contains a number of important bug
+ > fixes.
+ 
+ Well, the pci-reorg patch is just wrong with tht remaining stuff
+ and breaks the portable I/O code for IP27 and SN2 I'm working on.

I have not heard any compelling reasons for keeping non-ia64, non-Altix
code in the ia64, Altix code base. The code re-org is aimed towards a
new ASIC we are working on - we feel it is needed.


+ Just kill that pointless renaming and it's okay - the functional
+ changes are fine anyway.  Also please let Pat fix the bunch of other

One can always argue that renaming is pointless - since it doesn't
change the logic - but we'd like to keep the new names.


+ issues before merging, it's not that much anyway..

I think I did. I sent another email with the changes I made for the
issues you raised - and updated the patches. If I missed any, please
let me know.

David or Andrew can you take these patches ?

Thanks,
-- Pat

