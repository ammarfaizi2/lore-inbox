Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbUKDEwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbUKDEwM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 23:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbUKDEwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 23:52:11 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:39678 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262064AbUKDEwD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 23:52:03 -0500
Date: Thu, 4 Nov 2004 10:30:39 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 0/6] AIO wait bit support
Message-ID: <20041104050039.GA4087@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20041103091036.GA4041@in.ibm.com> <20041103092311.GB2583@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103092311.GB2583@holomorphy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 01:23:11AM -0800, William Lee Irwin III wrote:
> On Wed, Nov 03, 2004 at 02:40:36PM +0530, Suparna Bhattacharya wrote:
> > The series of patches that follow integrate AIO with 
> > William Lee Irwin's wait bit changes, to support asynchronous
> > page waits.
> 
> Thank you for pursuing this. I apologize for not participating more
> directly in the follow-up.
> 
> I also apologize for mentioning this, but I'm disturbed by current
> events right now, so I won't be evaluating these in any technical
> sense for at least a few days.

The main change to the wait bit code is the addition of a wait queue
argument to the action routine, and abstracting the wait bit key
check into a separate function. Rest of the stuff is mostly in aioland.

Regards
Suparna

> 
> 
> -- wli
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

