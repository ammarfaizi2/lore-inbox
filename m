Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbVIMGiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbVIMGiL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 02:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbVIMGiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 02:38:11 -0400
Received: from 66-23-228-155.clients.speedfactory.net ([66.23.228.155]:36814
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S932372AbVIMGiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 02:38:10 -0400
Date: Tue, 13 Sep 2005 02:33:59 -0400
From: Sonny Rao <sonny@burdell.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
Message-ID: <20050913063359.GA29715@kevlar.burdell.org>
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 08:34:17PM -0700, Linus Torvalds wrote:
<snip> 
> On the filesystem level, FUSE got merged, and ntfs and xfs got updated. In 
> the core VFS layer, the "struct files" thing is now handled with RCU and 
> has less expensive locking.

I hope this means that people will be more accepting of multi-threaded
benchmarks (who needs real apps... ;-)) which do open() and close().


Yes, no?

Sonny
 
