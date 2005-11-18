Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161251AbVKRV5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161251AbVKRV5N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 16:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161252AbVKRV5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 16:57:13 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:18223 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1161251AbVKRV5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 16:57:12 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Marvell SATA fixes v2
X-Message-Flag: Warning: May contain useful information
References: <437D2DED.5030602@pobox.com>
	<Pine.LNX.4.44.0511182241420.5095-100000@kenzo.iwr.uni-heidelberg.de>
	<20051118215209.GA9425@havoc.gtf.org>
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 18 Nov 2005 13:57:03 -0800
In-Reply-To: <20051118215209.GA9425@havoc.gtf.org> (Jeff Garzik's message of
 "Fri, 18 Nov 2005 16:52:09 -0500")
Message-ID: <52veyp39hs.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 18 Nov 2005 21:57:04.0553 (UTC) FILETIME=[030A1990:01C5EC8B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Jeff> Yes, for both 50xx and 60xx, I had to turn off MSI in order
    Jeff> to get sata_mv to work...

Sounds like MSI is broken in the Marvell chip.  This is exactly the
type of knowledge that needs to be in the low-level driver: which
devices/revisions don't have working MSI.

 - R.
