Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279589AbRKIHSA>; Fri, 9 Nov 2001 02:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279617AbRKIHRv>; Fri, 9 Nov 2001 02:17:51 -0500
Received: from pizda.ninka.net ([216.101.162.242]:13442 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S279589AbRKIHRh>;
	Fri, 9 Nov 2001 02:17:37 -0500
Date: Thu, 08 Nov 2001 23:17:17 -0800 (PST)
Message-Id: <20011108.231717.85686073.davem@redhat.com>
To: akpm@zip.com.au
Cc: ak@suse.de, anton@samba.org, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3BEB7DA6.BC8793B1@zip.com.au>
In-Reply-To: <20011108.220444.95062095.davem@redhat.com>
	<20011109073946.A19373@wotan.suse.de>
	<3BEB7DA6.BC8793B1@zip.com.au>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@zip.com.au>
   Date: Thu, 08 Nov 2001 22:54:30 -0800
   
   I played with that earlier in the year.  Shrinking the hash table
   by a factor of eight made no measurable difference to anything on
   a Pentium II.  The hash distribution was all over the place though.
   Lots of buckets with 1-2 pages, lots with 12-13.

What is the distribution when you don't shrink the hash
table?

Franks a lot,
David S. Miller
davem@redhat.com
