Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279627AbRKIHpD>; Fri, 9 Nov 2001 02:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279631AbRKIHoy>; Fri, 9 Nov 2001 02:44:54 -0500
Received: from pizda.ninka.net ([216.101.162.242]:38018 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S279627AbRKIHoj>;
	Fri, 9 Nov 2001 02:44:39 -0500
Date: Thu, 08 Nov 2001 23:44:30 -0800 (PST)
Message-Id: <20011108.234430.102576804.davem@redhat.com>
To: akpm@zip.com.au
Cc: mingo@elte.hu, ak@suse.de, anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3BEB8728.801344DC@zip.com.au>
In-Reply-To: <3BEB82B8.541558CA@zip.com.au>
	<Pine.LNX.4.33.0111090920240.2240-100000@localhost.localdomain>
	<3BEB8728.801344DC@zip.com.au>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@zip.com.au>
   Date: Thu, 08 Nov 2001 23:35:04 -0800

   b) Except for certain specialised workloads, a lookup is usually
      associated with a big memory copy, so none of it matters and

I disagree, cache pollution always matters.  Especially, if the cpu
does memcpy's using cache-bypass-on-miss.

Franks a lot,
David S. Miller
davem@redhat.com
