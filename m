Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265804AbUA1CsK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 21:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265810AbUA1CsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 21:48:10 -0500
Received: from thunk.org ([140.239.227.29]:60580 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S265804AbUA1CsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 21:48:05 -0500
Date: Tue, 27 Jan 2004 21:47:12 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@infradead.org>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       Florian Huber <florian.huber@mnet-online.de>,
       JFS Discussion <jfs-discussion@oss.software.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Jfs-discussion] md raid + jfs + jfs_fsck
Message-ID: <20040128024712.GA23831@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Christoph Hellwig <hch@infradead.org>,
	Dave Kleikamp <shaggy@austin.ibm.com>,
	Florian Huber <florian.huber@mnet-online.de>,
	JFS Discussion <jfs-discussion@oss.software.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1075230933.11207.84.camel@suprafluid> <1075231718.21763.28.camel@shaggy.austin.ibm.com> <1075232395.11203.94.camel@suprafluid> <1075236185.21763.89.camel@shaggy.austin.ibm.com> <20040127205324.A19913@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040127205324.A19913@infradead.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27, 2004 at 08:53:24PM +0000, Christoph Hellwig wrote:
> Yes, it does.  But JFS should get the right size from the gendisk anyway.
> Or did you create the raid with the filesystem already existant?  While that
> appears to work for a non-full ext2/ext3 filesystem it's not something you
> should do because it makes the filesystem internal bookkeeping wrong and
> you'll run into trouble with any filesystem sooner or later.

The key words here is *appears* to work.  No matter what the
filesystem, as Chrisoph says, you'll run into trouble sooner or
later....

							- Ted
