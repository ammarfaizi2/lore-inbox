Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751528AbWHJUXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbWHJUXf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbWHJUXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:23:34 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:59504 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751528AbWHJUXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 16:23:10 -0400
Date: Thu, 10 Aug 2006 22:23:08 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Theodore Tso <tytso@mit.edu>, Mingming Cao <cmm@us.ibm.com>, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 2/5] Register ext3dev filesystem
Message-ID: <20060810202307.GB12766@harddisk-recovery.com>
References: <1155172642.3161.74.camel@localhost.localdomain> <20060810092021.GB11361@harddisk-recovery.com> <20060810175920.GC19238@thunk.org> <44DB8EBE.6060003@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44DB8EBE.6060003@garzik.org>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 03:53:34PM -0400, Jeff Garzik wrote:
> Theodore Tso wrote:
> > On Thu, Aug 10, 2006 at 11:20:22AM +0200, Erik Mouw wrote:
> >> On Wed, Aug 09, 2006 at 06:17:22PM -0700, Mingming Cao wrote:
> >>> Register ext4 filesystem as ext3dev filesystem in kernel.
> >> Why confuse users with the name "ext3dev"? If a filesystem lives in
> >> fs/blah/, it's registered as "blah" and can be mounted with "-t blah".
> >> Just register the filesystem as "ext4" and mark it "EXPERIMENTAL" in
> >> Kconfig.
> > 
> > We had this discussion on LKML.  There were those who were concerned
> > that it would not be enough just to mark it be EXPERIMENTAL.
> 
> I _want_ to agree with Erik, but I must agree:  CONFIG_EXPERIMENTAL is 
> pretty worthless in practice :(  It's not maintained rigorously, and 
> distros _always_ enable it, because otherwise they would often omit key 
> drivers that people actively use.
> 
> So, while my own personal preference would be to follow Erik's 
> suggestion...  thinking realistically, an fstype change from "ext3dev" 
> to "ext4" is a far more obvious-to-users method of creating a 
> devel/production line of demarcation.

So what about "ext4dev"? That shows that the filesystem is not ext3 and
experimental.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
