Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130237AbRAGTLz>; Sun, 7 Jan 2001 14:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130338AbRAGTLp>; Sun, 7 Jan 2001 14:11:45 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:47012 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S130237AbRAGTLh>;
	Sun, 7 Jan 2001 14:11:37 -0500
Date: Sun, 7 Jan 2001 14:10:52 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
In-Reply-To: <20010107210036.G25076@mea-ext.zmailer.org>
Message-ID: <Pine.GSO.4.30.0101071408140.18916-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Jan 2001, Matti Aarnio wrote:

> 	Read what I wrote about the issue to Alan.
> 	Ben's code has no problems with receiving VLANs with network
> 	cards which have "hardware support" for VLANs.
>

OK. I suppose an skb->vlan_tag is passed to the driver and it will know
what to do with it (pass it on a descriptor etc).

cheers,
jamal

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
