Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266485AbUHBNik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266485AbUHBNik (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 09:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266498AbUHBNik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 09:38:40 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:54025 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266485AbUHBNij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 09:38:39 -0400
Date: Mon, 2 Aug 2004 14:38:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>, dipankar@in.ibm.com,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [patchset] Lockfree fd lookup 1 of 5
Message-ID: <20040802143825.A5073@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ravikiran G Thirumalai <kiran@in.ibm.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Greg KH <greg@kroah.com>, dipankar@in.ibm.com,
	viro@parcelfarce.linux.theplanet.co.uk
References: <20040802101053.GB4385@vitalstatistix.in.ibm.com> <20040802101350.GC4385@vitalstatistix.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040802101350.GC4385@vitalstatistix.in.ibm.com>; from kiran@in.ibm.com on Mon, Aug 02, 2004 at 03:43:52PM +0530
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2004 at 03:43:52PM +0530, Ravikiran G Thirumalai wrote:
> Here's the first patch.  This patch 'shrinks' struct kref by removing
> the release pointer in the struct kref.  GregKH has applied this to his tree

What's the advantage of this kref API over opencoded atomic_t usage?

