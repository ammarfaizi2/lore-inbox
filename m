Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266505AbUJWKXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266505AbUJWKXa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 06:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266473AbUJWKWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 06:22:36 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:37387 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266498AbUJWKWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 06:22:07 -0400
Date: Sat, 23 Oct 2004 11:22:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "C.Y.M" <syphir@syphir.sytes.net>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Unknown symbol kill_proc_info in 2.6.10-rc1
Message-ID: <20041023102203.GB30449@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"C.Y.M" <syphir@syphir.sytes.net>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <417A2292.9090008@syphir.sytes.net> <20041023095714.GD30137@infradead.org> <417A2CBF.9060805@syphir.sytes.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417A2CBF.9060805@syphir.sytes.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2004 at 03:04:47AM -0700, C.Y.M wrote:
> Christoph Hellwig wrote:
> >On Sat, Oct 23, 2004 at 02:21:22AM -0700, C.Y.M wrote:
> >
> >>After building 2.6.10-rc1, i was unable to load my "lufs" module due to 
> >>an unknown symbol error (kill_proc_info).  When I examined the 
> >>2.6.10-rc1 patch, I noticed that "EXPORT_SYMBOL(kill_proc_info);" was 
> >>removed from signal.c.  With the following patch, I was able to resolve 
> >>my problem, but I am not sure if this is the correct method.  Is there a 
> >>reason why the kill_proc_info symbol is no longer exported?
> >
> >
> >Because it's not an API you should be using.
> >
> >
> Is there an alternative?

Maybe you could explain what you're actually trying to do at a higher
level first.

