Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269878AbUIDKyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269878AbUIDKyM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 06:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269876AbUIDKyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 06:54:12 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:23229 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S269878AbUIDKyH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 06:54:07 -0400
Date: Sat, 4 Sep 2004 11:54:06 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Keith Whitwell <keith@tungstengraphics.com>,
       Christoph Hellwig <hch@infradead.org>, Jon Smirl <jonsmirl@yahoo.com>,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
In-Reply-To: <41399CA2.3080607@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0409041151200.25475@skynet>
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com>
 <Pine.LNX.4.58.0409040145240.25475@skynet> <20040904102914.B13149@infradead.org>
 <41398EBD.2040900@tungstengraphics.com> <20040904104834.B13362@infradead.org>
 <413997A7.9060406@tungstengraphics.com> <20040904112535.A13750@infradead.org>
 <4139995E.5030505@tungstengraphics.com> <41399CA2.3080607@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Just out of interest, what would the scenario be if you do if you could
> get a compatible driver?

you just grab a DRI snapshot which contains new userspace and DRM, and
install it... it builds the DRM against your current kernel, now if your
current kernel has a DRM module built-in which is a different version, you
are screwed, snapshot process breaks..

It's one of the major successes I feel of the DRI project, those
snapshots allowed people with Radeon IGP chipsets to get 3d acceleration
long before now (they still can't get it any current distro), same goes
for i915 as Keith points out..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

