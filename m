Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbUDENbB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 09:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbUDENbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 09:31:00 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:22027 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262388AbUDENa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 09:30:59 -0400
Date: Mon, 5 Apr 2004 14:30:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dan Aloni <da-x@colinux.org>
Cc: Cooperative Linux Development 
	<colinux-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: coLinux benchmarks
Message-ID: <20040405143056.A5621@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dan Aloni <da-x@colinux.org>,
	Cooperative Linux Development <colinux-devel@lists.sourceforge.net>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20040405131520.GA4395@callisto.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040405131520.GA4395@callisto.yi.org>; from da-x@colinux.org on Mon, Apr 05, 2004 at 03:15:20PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The VM shows better results than the host. What gives? Perhaps
> it is because of the combination of the host and guest's buffer 
> cache? I'd like to know about more percise benchmarking methods 
> for VMs.

How are the virtual disks for the VM implemented?  If you're doing
direct I/O these numbers are indeed strange.  If not OTOH that's
expected because even synchronous I/O in the guest is actually
async which makes it a lot faster.

