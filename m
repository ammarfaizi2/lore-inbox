Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268069AbUJFN00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268069AbUJFN00 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 09:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268356AbUJFN0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 09:26:25 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:9480 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268069AbUJFN0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 09:26:14 -0400
Date: Wed, 6 Oct 2004 14:26:10 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jakob Oestergaard <jakob@unthought.net>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: NFS+SMP+XFS problems, Take II
Message-ID: <20041006142610.A30867@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jakob Oestergaard <jakob@unthought.net>,
	linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
References: <20041006125931.GU18307@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041006125931.GU18307@unthought.net>; from jakob@unthought.net on Wed, Oct 06, 2004 at 02:59:31PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 02:59:31PM +0200, Jakob Oestergaard wrote:
> 
> Dear all,
> 
> The dcache patch (originally from Neil Brown, adapted for 2.6.8.1 by me)
> has been included in the current 2.6.9 RC. It *seemed* that this patch
> solved the XFS+NFS+SMP problem completely, and that it would then be
> possible to finally run an NFS server with XFS on an SMP machine.
> 
> Well, close, but not close enough.

As I told in the thread it's not enough.  I checked in two more XFS fixes,
they're all in 2.6.9-rc3.

