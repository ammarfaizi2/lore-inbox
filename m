Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264806AbUDWNfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264806AbUDWNfa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 09:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264807AbUDWNfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 09:35:30 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:40974 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264806AbUDWNf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 09:35:26 -0400
Date: Fri, 23 Apr 2004 14:35:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: raven@themaw.net
Cc: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc2-mm1
Message-ID: <20040423143521.A1961@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, raven@themaw.net,
	Andrew Morton <akpm@osdl.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040421014544.37942eb4.akpm@osdl.org> <Pine.LNX.4.58.0404222321310.6767@donald.themaw.net> <20040423131149.B1218@infradead.org> <Pine.LNX.4.58.0404232125420.5889@donald.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0404232125420.5889@donald.themaw.net>; from raven@themaw.net on Fri, Apr 23, 2004 at 09:33:10PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2004 at 09:33:10PM +0800, raven@themaw.net wrote:
> autofs3 requires it to behave as per the little description I put in.
> 
> So is the first version what we want?
> Should I do a patch which reverts it or should I do a new patch that 
> adds the prototype I originally missed?
> 
> Be good to clear up what I need to do before I spend more time on it.

It's say keep may_umount as is, and do a no-argument may_umount_tree
in namespace.c aswell.  As for what patches is best ask akpm.

