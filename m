Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263776AbUJ3AdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263776AbUJ3AdN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 20:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbUJ3A37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 20:29:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:9601 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263749AbUJ3A0l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 20:26:41 -0400
Date: Fri, 29 Oct 2004 17:30:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, jeremy@sgi.com
Subject: Re: Buffered I/O slowness
Message-Id: <20041029173045.32722ac0.akpm@osdl.org>
In-Reply-To: <200410291716.25277.jbarnes@engr.sgi.com>
References: <200410251814.23273.jbarnes@engr.sgi.com>
	<200410291046.48469.jbarnes@engr.sgi.com>
	<20041029160827.4dc29c3f.akpm@osdl.org>
	<200410291716.25277.jbarnes@engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes <jbarnes@engr.sgi.com> wrote:
>
> > I'm not sure that we know what's going on yet.  I certainly don't.  The
> > above numbers look good, so what's the problem???
> 
> The numbers are ~1/3 of what the machine is capable of with direct I/O.

Are there CPU cycles to spare?  If you have just one CPU copying 1GB/sec
out of pagecache, maybe it is pegged?
