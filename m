Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262058AbVEOJyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbVEOJyt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 05:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbVEOJyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 05:54:49 -0400
Received: from colin.muc.de ([193.149.48.1]:61966 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262058AbVEOJyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 05:54:47 -0400
Date: 15 May 2005 11:54:46 +0200
Date: Sun, 15 May 2005 11:54:46 +0200
From: Andi Kleen <ak@muc.de>
To: Diego Calleja <diegocg@gmail.com>
Cc: gmicsko@szintezis.hu, linux-kernel@vger.kernel.org
Subject: Re: Hyper-Threading Vulnerability
Message-ID: <20050515095446.GE68736@muc.de>
References: <1115963481.1723.3.camel@alderaan.trey.hu> <m164xnatpt.fsf@muc.de> <20050513211609.75216bf8.diegocg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050513211609.75216bf8.diegocg@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 09:16:09PM +0200, Diego Calleja wrote:
> El Fri, 13 May 2005 20:03:58 +0200,
> Andi Kleen <ak@muc.de> escribi?:
> 
> 
> > This is not a kernel problem, but a user space problem. The fix 
> > is to change the user space crypto code to need the same number of cache line
> > accesses on all keys. 
> 
> 
> However they've patched the FreeBSD kernel to "workaround?" it:
> ftp://ftp.freebsd.org/pub/FreeBSD/CERT/patches/SA-05:09/htt5.patch

That's a similar stupid idea as they did with the disk write
cache (lowering the MTBFs of their disks by considerable factors,
which is much worse than the power off data loss problem) 
Let's not go down this path please.

-Andi

