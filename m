Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbVJXDaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbVJXDaP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 23:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbVJXDaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 23:30:15 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:16928 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750944AbVJXDaO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 23:30:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=cJK1ARkdtDNnwand+G/KXF2DYGV15ncJYBxR/ailexINQQnlz0pzidXuPURG9OKe9ysmnGixLE7kQ1GT5VEaE0JkRvGJyQH4h0FUmaWyNJIOL+yeFU4jJiOEU7q50NywP+6nmp53FcnPGfFNFX1BB75nh7ZrXDt3wS/Ap0zO/zQ=
Date: Mon, 24 Oct 2005 12:30:07 +0900
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-block-2.6:generic-dispatch] kill max_back_kb handling
Message-ID: <20051024033007.GB14202@htj.dyndns.org>
References: <20051024032731.GA14202@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051024032731.GA14202@htj.dyndns.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2005 at 12:27:31PM +0900, Tejun Heo wrote:
>  Hello, Jens.
> 
>  This patch kills max_back_kb handling from elv_dispatch_sort() and
> kills max_back_kb field from struct request_queue.  The implementation
> was broken (subtracted bytes from blocks) and the usefulness of the

 Oops, above line is wrong.  Can you please kill the sentence about
breakage when committing?  Thanks.

> feature is doubtful.

-- 
tejun
