Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbULNGbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbULNGbM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 01:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbULNGbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 01:31:12 -0500
Received: from palrel11.hp.com ([156.153.255.246]:12781 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261433AbULNGbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 01:31:06 -0500
Date: Tue, 14 Dec 2004 17:31:06 +1100
From: Martin Pool <mbp@sourcefrog.net>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rescan partitions returns EIO since 2.6.8
Message-ID: <20041214063105.GI29999@hp.com>
Mail-Followup-To: Martin Pool <mbp@sourcefrog.net>,
	Andries Brouwer <Andries.Brouwer@cwi.nl>,
	linux-kernel@vger.kernel.org
References: <200412051403.iB5E3EJ01749@apps.cwi.nl> <20041206004722.GD26060@hp.com> <20041206015052.GC4734@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041206015052.GC4734@apps.cwi.nl>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  6 Dec 2004, Andries Brouwer <Andries.Brouwer@cwi.nl> wrote:
> On Mon, Dec 06, 2004 at 11:47:22AM +1100, Martin Pool wrote:
> > On  5 Dec 2004, Andries.Brouwer@cwi.nl wrote:
> > To me it seems more correct that a request to read the partition table
> > should fail if the partition table can't be read.
> 
> I do not view BLKRRPART as a request to read the partition table.
> It is a request to revalidate: "if the disk is in use, return EBUSY,
> otherwise, discard any old information, read any new information".
> If the disk is blank then there is no new information to read,
> that is not an error, and certainly not an I/O error.
> 
> > if you really want to roll it back I won't object.
> 
> Yes, I think I want to - am getting worried mail from people
> who very much dislike I/O errors on a brand-new disk.

OK, my mistake.  Please take it out.

-- 
Martin 
