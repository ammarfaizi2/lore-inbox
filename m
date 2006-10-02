Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbWJBKAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbWJBKAM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 06:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWJBKAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 06:00:12 -0400
Received: from rs384.securehostserver.com ([72.22.69.69]:56074 "HELO
	rs384.securehostserver.com") by vger.kernel.org with SMTP
	id S1750985AbWJBKAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 06:00:09 -0400
Subject: Re: [RFC][PATCH 0/2] Swap token re-tuned
From: Ashwin Chaugule <ashwin.chaugule@celunite.com>
Reply-To: ashwin.chaugule@celunite.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <20061001155608.0a464d4c.akpm@osdl.org>
References: <1159555312.2141.13.camel@localhost.localdomain>
	 <20061001155608.0a464d4c.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 15:30:01 +0530
Message-Id: <1159783202.5574.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-01 at 15:56 -0700, Andrew Morton wrote:

> Another workload which it would be useful to benchmark is a kernel compile
> - say, boot with `mem=16M' and time `make -j4 vmlinux' (numbers may need
> tuning).
> 

This is what I got :

mem=64M


Upstream:
2.6.18
make -j 4 vmlinux


real    31m26.021s
user    4m32.140s
sys     0m23.340s

------------------

My patch:

real    27m42.984s
user    4m33.800s
sys     0m22.080s


Ashwin

