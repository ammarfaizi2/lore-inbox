Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263845AbTEOHlR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 03:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263825AbTEOHlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 03:41:17 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:28045 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262735AbTEOHlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 03:41:14 -0400
Date: Thu, 15 May 2003 09:54:01 +0200
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       acme@conectiva.com.br
Subject: Re: 2.5 qdisc problem
Message-ID: <20030515075401.GX15261@suse.de>
References: <20030514122624.GA20480@babylon.d2dc.net> <20030514125941.GI15261@suse.de> <20030514130838.GJ15261@suse.de> <20030514.125923.102559449.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514.125923.102559449.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14 2003, David S. Miller wrote:
> I believe the problem has something to do with changing when the
> rtnetlink/netlink init runs, not the socket owner stuff.

I didn't expect the socket owner stuff either, but one patch backout
made the kernel crap out when compiling so I had to get the duct tape :)

Anyways, bk-current works, I'm happy again.

-- 
Jens Axboe

