Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265022AbTFCOUR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 10:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265024AbTFCOUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 10:20:17 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:8589
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S265022AbTFCOUQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 10:20:16 -0400
Date: Tue, 3 Jun 2003 10:33:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: David van Hoose <davidvh@cox.net>
Cc: Margit Schubert-While <margitsw@t-online.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21rc6-ac2
Message-ID: <20030603143343.GB2079@gtf.org>
References: <5.1.0.14.2.20030603143135.00ae9d40@pop.t-online.de> <3EDC9B6B.3000809@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EDC9B6B.3000809@cox.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03, 2003 at 08:58:19AM -0400, David van Hoose wrote:
> I agree on the march support. I've been using my own trivial patch for 
> the i386 Makefile to have direct support for the P3 and P4. Just trying 
> to figure out whether adding sse2 support on the compile line will 
> create problems. GCC does not use SSE(2) unless you explicitly tell it to.

Easy:  do _not_ turn on gcc's sse(2) support, when building the kernel.

	Jeff



