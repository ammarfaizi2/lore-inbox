Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129778AbRAGTBD>; Sun, 7 Jan 2001 14:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130063AbRAGTAy>; Sun, 7 Jan 2001 14:00:54 -0500
Received: from mail.zmailer.org ([194.252.70.162]:51982 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129778AbRAGTAs>;
	Sun, 7 Jan 2001 14:00:48 -0500
Date: Sun, 7 Jan 2001 21:00:36 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: jamal <hadi@cyberus.ca>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
Message-ID: <20010107210036.G25076@mea-ext.zmailer.org>
In-Reply-To: <3A58BD44.1381D182@candelatech.com> <Pine.GSO.4.30.0101071317440.18916-100000@shell.cyberus.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.30.0101071317440.18916-100000@shell.cyberus.ca>; from hadi@cyberus.ca on Sun, Jan 07, 2001 at 01:21:11PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2001 at 01:21:11PM -0500, jamal wrote:
> On Sun, 7 Jan 2001, Ben Greear wrote:
> > > Question: How do devices with hardware vlan support fit into your model ?
> > I don't know of any, and I'm not sure how they would be supported.
> 
> erm, this is a MUST. You MUST factor the hardware VLANs and be totaly
> 802.1q compliant. Also of interest is 802.1P and D. We must have full
> compliance, not some toy emulation.

	Read what I wrote about the issue to Alan.
	Ben's code has no problems with receiving VLANs with network
	cards which have "hardware support" for VLANs.

	But this is far away from device name hashes.
	(Which aren't in data reception or sending fastpaths, anyway.)

> cheers,
> jamal

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
