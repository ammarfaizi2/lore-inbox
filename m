Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVFTVtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVFTVtK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbVFTVsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 17:48:21 -0400
Received: from kanga.kvack.org ([66.96.29.28]:41158 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S261642AbVFTVoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:44:37 -0400
Date: Mon, 20 Jun 2005 17:46:14 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: linux-aio@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: aio_down() patch series -- cancellation support added
Message-ID: <20050620214614.GC6628@kvack.org>
References: <20050620213835.GA6628@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620213835.GA6628@kvack.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add linux-kernel to the Cc list...

On Mon, Jun 20, 2005 at 05:38:35PM -0400, Benjamin LaHaise wrote:
> Hello all,
> 
> The patch series at http://www.kvack.org/~bcrl/patches/aio-2.6.12-A1/ 
> now adds support for cancellation of an aio_down() operation.  The 
> races should be correctly handled by introducing per-kiocb locking 
> that serialises ->ki_cancel() and ->ki_retry().  The interesting patch 
> additions are 40_lock_kiocb 50_aio_down_cancel.diff.  Comments?
> 
> 		-ben
> -- 
> "Time is what keeps everything from happening all at once." -- John Wheeler
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
