Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319575AbSIHHkA>; Sun, 8 Sep 2002 03:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319576AbSIHHkA>; Sun, 8 Sep 2002 03:40:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24468 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319575AbSIHHkA>;
	Sun, 8 Sep 2002 03:40:00 -0400
Date: Sun, 08 Sep 2002 00:37:00 -0700 (PDT)
Message-Id: <20020908.003700.07120871.davem@redhat.com>
To: akpm@digeo.com
Cc: wli@holomorphy.com, ciarrocchi@linuxmail.org, linux-kernel@vger.kernel.org
Subject: Re: LMbench2.0 results
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D7B0177.6A35FE9B@digeo.com>
References: <3D7A2768.E5C85EB@digeo.com>
	<20020907200334.GI888@holomorphy.com>
	<3D7B0177.6A35FE9B@digeo.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@digeo.com>
   Date: Sun, 08 Sep 2002 00:51:19 -0700
   
   So it's a bit of rmap in there.  I'd have to compare with a 2.4
   profile and fiddle a few kernel parameters.  But I'm not sure
   that munmap of extremely sparsely populated pagtetables is very
   interesting?

Another issue is that x86 doesn't use a pagetable cache.  I think it
got killed from x86 when the pagetables in highmem went in.

This is all from memory.
