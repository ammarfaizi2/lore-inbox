Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWBZJ5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWBZJ5o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 04:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWBZJ5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 04:57:43 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40931 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751307AbWBZJ5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 04:57:43 -0500
Subject: Re: old radeon latency problem still unfixed?
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       Dave Airlie <airlied@linux.ie>
In-Reply-To: <20060226014437.327b1cc3.akpm@osdl.org>
References: <1140917787.24141.78.camel@mindpipe>
	 <20060226014437.327b1cc3.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 26 Feb 2006 10:57:39 +0100
Message-Id: <1140947860.2934.12.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-26 at 01:44 -0800, Andrew Morton wrote:
> Lee Revell <rlrevell@joe-job.com> wrote:
> >
> >  Users report that this patch:
> > 
> >  https://www.redhat.com/archives/fedora-devel-list/2004-June/msg00072.html
> > 
> >  is still needed to eliminate audio underruns for Radeon users.
> 
> That's a 2.6.4 patch which generates 100% rejects.
> 
> But still, if that patch helped and didn't throw a billion might_sleep()
> and people were using preemptible kernels then we have a lock_kernel()
> problem.  

lock_kernel() is a semaphore nowadays.... unless those people just
turned that off, at which point.. their problem ;)


