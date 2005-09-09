Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbVIIGqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbVIIGqa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 02:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbVIIGq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 02:46:29 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:23881 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751408AbVIIGq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 02:46:29 -0400
Date: Fri, 9 Sep 2005 08:46:27 +0200
From: Jens Axboe <axboe@suse.de>
To: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
Cc: "Moore, Eric Dean" <Eric.Moore@lsil.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, akpm@osdl.org
Subject: Re: can't boot 2.6.13
Message-ID: <20050909064624.GE6097@suse.de>
References: <D4CFB69C345C394284E4B78B876C1CF10AC92126@cceexc23.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF10AC92126@cceexc23.americas.cpqcorp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08 2005, Miller, Mike (OS Dev) wrote:
> Thanks, Eric.
> Anyone have any ideas why my cciss based system won't boot?

Hmm I thought Eric's suggestion was quite good, it bit me on a tiger as
well (you have to set _SPI or _FCI variant of the driver now). I see no
CISS detection at all, if your system has both perhaps the driver got
left out?

A boot log from a working system would help a lot.

-- 
Jens Axboe

