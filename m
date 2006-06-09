Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbWFIQDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbWFIQDZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbWFIQDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:03:24 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:12686 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030248AbWFIQDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:03:23 -0400
Message-ID: <44899BC5.60709@garzik.org>
Date: Fri, 09 Jun 2006 12:03:17 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Gerrit Huizenga <gh@us.ibm.com>
CC: Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <E1FojJ7-0002gC-9w@w-gerrit.beaverton.ibm.com>
In-Reply-To: <E1FojJ7-0002gC-9w@w-gerrit.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerrit Huizenga wrote:
> Jeff's approach taken to the rediculous would mean that we'd have
> ext versions 1-40 by now at least.  I don't think that helps much,
> either.

That's plainly silly.  Like everything else in life, it is a balance of 
costs.

At some point, ext3's fs-feature-flag approach increases the 
combinations of metadata variants you must support exponentially.

Moving to extents and 48bit (which I want) is a big enough step that, 
IMO, some of the support costs become far more obvious.

	Jeff


