Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbVHYFj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbVHYFj6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 01:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbVHYFj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 01:39:58 -0400
Received: from ozlabs.org ([203.10.76.45]:41135 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964803AbVHYFj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 01:39:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17165.22994.174870.856032@cargo.ozlabs.ibm.com>
Date: Thu, 25 Aug 2005 15:40:34 +1000
From: Paul Mackerras <paulus@samba.org>
To: Paul Jackson <pj@sgi.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: cpu_exclusive sched domains fix broke ppc64
In-Reply-To: <20050824223209.352a5f87.pj@sgi.com>
References: <17164.11361.437380.179789@cargo.ozlabs.ibm.com>
	<20050824223209.352a5f87.pj@sgi.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson writes:

> ... however ... question for Paul M. ...  what version of gcc did this fail on?

The gcc-4.0.2 in Debian/ppc sid, which is biarch.

> I finally got my crosstools setup working for me again, and building
> a powerpc64 using gcc-3.4.0 on my Intel PC box does _not_ fail.  That

Did you have CONFIG_NUMA=y ?

Paul.
