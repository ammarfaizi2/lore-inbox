Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422668AbWHJR7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422668AbWHJR7u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 13:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422670AbWHJR7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 13:59:50 -0400
Received: from thunk.org ([69.25.196.29]:29874 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1422668AbWHJR7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 13:59:48 -0400
Date: Thu, 10 Aug 2006 13:59:20 -0400
From: Theodore Tso <tytso@mit.edu>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Mingming Cao <cmm@us.ibm.com>, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 2/5] Register ext3dev filesystem
Message-ID: <20060810175920.GC19238@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Erik Mouw <erik@harddisk-recovery.com>,
	Mingming Cao <cmm@us.ibm.com>, akpm@osdl.org,
	linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <1155172642.3161.74.camel@localhost.localdomain> <20060810092021.GB11361@harddisk-recovery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060810092021.GB11361@harddisk-recovery.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 11:20:22AM +0200, Erik Mouw wrote:
> On Wed, Aug 09, 2006 at 06:17:22PM -0700, Mingming Cao wrote:
> > Register ext4 filesystem as ext3dev filesystem in kernel.
> 
> Why confuse users with the name "ext3dev"? If a filesystem lives in
> fs/blah/, it's registered as "blah" and can be mounted with "-t blah".
> Just register the filesystem as "ext4" and mark it "EXPERIMENTAL" in
> Kconfig.

We had this discussion on LKML.  There were those who were concerned
that it would not be enough just to mark it be EXPERIMENTAL.

						- Ted
