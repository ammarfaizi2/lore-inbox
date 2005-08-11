Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbVHKQgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbVHKQgH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 12:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbVHKQgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 12:36:07 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61108 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751108AbVHKQgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 12:36:05 -0400
Date: Thu, 11 Aug 2005 17:35:41 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Zach Brown <zab@zabbo.net>
Cc: Pekka J Enberg <penberg@cs.Helsinki.FI>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       David Teigland <teigland@redhat.com>, Pekka Enberg <penberg@gmail.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: GFS
Message-ID: <20050811163541.GA4351@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Zach Brown <zab@zabbo.net>, Pekka J Enberg <penberg@cs.Helsinki.FI>,
	Mark Fasheh <mark.fasheh@oracle.com>,
	David Teigland <teigland@redhat.com>,
	Pekka Enberg <penberg@gmail.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, linux-cluster@redhat.com,
	Andreas Dilger <adilger@clusterfs.com>
References: <Pine.LNX.4.58.0508111006470.13379@sbz-30.cs.Helsinki.FI> <42FB7DE5.2080506@zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42FB7DE5.2080506@zabbo.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 at 09:33:41AM -0700, Zach Brown wrote:
> ordering when multiple file systems are concerned.  It doesn't record
> the ranges of the mappings involved so Lustre can't properly use its
> range locks.

That doesn't matter.  Please don't put in any effort for lustre special
cases - they are unwilling to cooperate and they'll get what they deserve.

> And finally, it doesn't prohibit mapping operations for
> the duration of the IO -- the whole reason we ended up in this thread in
> the first place :)
> 
> Christoph, would you be interested in looking at a more thorough patch
> if I threw one together?

Sure, I'm not sure that'll happen in a timely fashion, though.

