Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265108AbUHCHRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265108AbUHCHRX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 03:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265255AbUHCHRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 03:17:23 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:24207 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265108AbUHCHRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 03:17:22 -0400
Date: Tue, 3 Aug 2004 09:17:12 +0200
From: Jens Axboe <axboe@suse.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cd problems
Message-ID: <20040803071712.GI23504@suse.de>
References: <cehqak$1pq$1@sea.gmane.org> <celpmo$gff$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <celpmo$gff$1@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02 2004, Bill Davidsen wrote:
> Alexander E. Patrakov wrote:
> 
> >Remember that it is still possible to write CDs through ide-cd in 2.4.x 
> >using some pre-alpha code in cdrecord:
> >
> >cdrecord dev=ATAPI:1,1,0 image.iso
> >
> But... doesn't that require access to the sg device?

(don't snip cc lists...)

No, it goes through /dev/hdX or /dev/srX

-- 
Jens Axboe

