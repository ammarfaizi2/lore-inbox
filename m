Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268101AbUJJEdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268101AbUJJEdL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 00:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268105AbUJJEdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 00:33:11 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:15060 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268101AbUJJEdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 00:33:09 -0400
Date: Sun, 10 Oct 2004 14:48:19 +1000
From: Greg Banks <gnb@sgi.com>
To: Ed Schouten <ed@il.fontys.nl>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [Patch] lockd: remove hardcoded maximum NLM cookie length
Message-ID: <20041010044819.GC14977@sgi.com>
References: <60256.217.121.83.210.1097351510.squirrel@217.121.83.210>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60256.217.121.83.210.1097351510.squirrel@217.121.83.210>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 09, 2004 at 09:51:50PM +0200, Ed Schouten wrote:
> Hi guys,
> 
> At the moment, the NLM cookie length is fixed to 8 bytes, while 1024 is
> the theoretical maximum. FreeBSD uses 16 bytes, Mac OS X uses 20 bytes.
> Therefore we need to make the length dynamic (which I set to 32 bytes).

MacOS X has used 8 byte cookies since 10.3.4, so FreeBSD is the only
known interop issue.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.
