Return-Path: <linux-kernel-owner+w=401wt.eu-S932870AbXATAYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932870AbXATAYO (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 19:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932869AbXATAYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 19:24:14 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:53830 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932810AbXATAYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 19:24:13 -0500
Message-ID: <45B1612A.40109@pobox.com>
Date: Fri, 19 Jan 2007 19:24:10 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sata_mv HighPoint 2310 support (88SX7042)
References: <20070119003959.GA23298@lixom.net>
In-Reply-To: <20070119003959.GA23298@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olof Johansson wrote:
> Hi,
> 
> With the following patch, my HighPoint 2310 with a Marvell 88SX7042 on
> it seems to work OK.
> 
> The controller only has 4 ports, with MV_FLAG_DUAL_HC it seems to init 8
> ports and fails miserably at probe time. There are no other devices mapped
> to that chip, maybe it was just incorrectly specified in the first place?
> 
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

The docs say 8-port.

Nonetheless, I will apply your patch, since working-in-the-field proof 
trumps docs on occasion (including this occasion).

We'll revisit if someone complains that their 7042 only sees 4 of 8 ports.

	Jeff



