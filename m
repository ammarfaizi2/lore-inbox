Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbTDRRxi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 13:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbTDRRxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 13:53:38 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:25057 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263173AbTDRRxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 13:53:37 -0400
Date: Fri, 18 Apr 2003 11:06:30 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@transmeta.com>, sfr@canb.auug.org.au,
       rusty@rustcorp.com.au
Cc: Andries.Brouwer@cwi.nl, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct loop_info64
Message-ID: <20030418180630.GA7247@kroah.com>
References: <20030418165506.GA6834@kroah.com> <Pine.LNX.4.44.0304181050430.2950-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304181050430.2950-100000@home.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 18, 2003 at 10:55:21AM -0700, Linus Torvalds wrote:
> 
> But we really should have a __ptr64 type too. There's just no sane way to
> tell gcc about it without requireing casts, which is inconvenient (which
> means that right now it you just have to use __u64 for pointers if you
> want to be able to share the structure across 32/64-bit architectures).

I think that's what Stephan and Rusty tried to do with the
kernel_ulong_t typedef in include/linux/mod_devicetable.h.

Maybe that typedef could be changed into the __ptr64 type?  Stephan?

thanks,

greg k-h
