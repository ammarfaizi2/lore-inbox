Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262173AbULQWKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbULQWKc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 17:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbULQWKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 17:10:32 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:51466 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262173AbULQWKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 17:10:20 -0500
Date: Fri, 17 Dec 2004 22:52:30 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: James Pearson <james-p@moving-picture.com>, linux-kernel@vger.kernel.org
Subject: Re: Reducing inode cache usage on 2.4?
Message-ID: <20041217215230.GK17946@alpha.home.local>
References: <41C316BC.1020909@moving-picture.com> <20041217151228.GA17650@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041217151228.GA17650@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

On Fri, Dec 17, 2004 at 01:12:28PM -0200, Marcelo Tosatti wrote:
(...)
> The default kernel shrinking ratio can be tuned for enhanced reclaim efficiency.

Thanks for having explained this. Up to now, after several series of find or
other FS-intensive tasks, I often launched a simple home-made program to which
I tell how much memory I want it to allocate (and touch), then it exits freeing
this amount of memory. A bit dangerous but really effective indeed !

I too will try to play with vm_vfs_scan_ratio, it seems appealing.

Cheers,
Willy

