Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWB1MHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWB1MHU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 07:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWB1MHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 07:07:19 -0500
Received: from mail.dvmed.net ([216.237.124.58]:56196 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932200AbWB1MHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 07:07:18 -0500
Message-ID: <44043CEE.70201@pobox.com>
Date: Tue, 28 Feb 2006 07:07:10 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Buesch <mbuesch@freenet.de>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, bcm43xx-dev@lists.berlios.de
Subject: Re: [PATCH] Generic hardware RNG support
References: <200602281229.12887.mbuesch@freenet.de>
In-Reply-To: <200602281229.12887.mbuesch@freenet.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch wrote:
> Andrew, consider inclusion of the following patch into -mm
> for further testing, please.
> 
> ---
> 
> This patch adds support for generic Hardware Random Number Generator
> drivers. This makes the usage of the bcm43xx internal RNG through
> /dev/hwrandom possible.
> 
> A patch against bcm43xx for your testing pleasure can be found at:
> ftp://ftp.bu3sch.de/misc/bcm43xx-d80211-hwrng.patch

Please merge with Deepak Saxena's generic RNG stuff, rather than 
duplicating efforts.

	Jeff



