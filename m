Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754325AbWKMKqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325AbWKMKqH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 05:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754424AbWKMKqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 05:46:07 -0500
Received: from brick.kernel.dk ([62.242.22.158]:63550 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1754325AbWKMKqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 05:46:04 -0500
Date: Mon, 13 Nov 2006 11:48:38 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Petr =?iso-8859-1?Q?Tesa=3F=EDk?= <ptesarik@suse.cz>
Cc: iss_storagedev@hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Update disk statistics for cciss and cpqarray devices
Message-ID: <20061113104838.GU15031@kernel.dk>
References: <1163414428.14165.4.camel@golias.tesarici.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1163414428.14165.4.camel@golias.tesarici.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13 2006, Petr Tesa?ík wrote:
> The request functions for cciss and cpqarray drivers do not update
> statistics upon request completion.  This would normally be done in
> end_that_request_first(), but this function is not used by these
> drivers, so the number of sectors read/written (as reported
> in /proc/diskstat and consequently also by utilities like iostat) is
> always zero.
> 
> The following patch adds correct statistics for both drivers.

A similar patch was already posted last week and is pending inclusion.

-- 
Jens Axboe

