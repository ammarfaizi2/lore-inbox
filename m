Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965107AbWFTG7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965107AbWFTG7D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 02:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965109AbWFTG7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 02:59:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61132 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965107AbWFTG7A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 02:59:00 -0400
Date: Tue, 20 Jun 2006 02:53:32 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Olson <olson@unixfolk.com>, mingo@elte.hu, ccb@acm.org,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [patch] increase spinlock-debug looping timeouts (write_lock and NMI)
Message-ID: <20060620065332.GA27444@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Dave Olson <olson@unixfolk.com>,
	mingo@elte.hu, ccb@acm.org, linux-kernel@vger.kernel.org,
	Nick Piggin <nickpiggin@yahoo.com.au>
References: <fa.VT2rwoX1M/2O/aO5crhlRDNx4YA@ifi.uio.no> <fa.Zp589GPrIISmAAheRowfRgZ1jgs@ifi.uio.no> <Pine.LNX.4.61.0606192231380.25413@osa.unixfolk.com> <20060619233947.94f7e644.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619233947.94f7e644.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 11:39:47PM -0700, Andrew Morton wrote:

 > fc4?  You seem to have an RH-FCx which doesn't enable
 > CONFIG_DEBUG_SPINLOCK.  Or maybe we didn't have all that debug code in
 > 2.6.16.  Doesn't matter, really.

>From the uname, it looks like a recompiled Fedora kernel
(probably with that option turned off).

 > > Pid: 4239, comm: mpi_multibw Not tainted 2.6.16-1.2096_FC4.rootsmp #1

We helpfully appended the whoami output to it at buildtime.

		Dave

-- 
http://www.codemonkey.org.uk
