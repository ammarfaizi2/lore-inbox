Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315720AbSFFKSq>; Thu, 6 Jun 2002 06:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316880AbSFFKSp>; Thu, 6 Jun 2002 06:18:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:51601 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315720AbSFFKSo>;
	Thu, 6 Jun 2002 06:18:44 -0400
Date: Thu, 06 Jun 2002 03:15:20 -0700 (PDT)
Message-Id: <20020606.031520.08940800.davem@redhat.com>
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] CONFIG_NR_CPUS
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3CFF3504.1DCD24E7@zip.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@zip.com.au>
   Date: Thu, 06 Jun 2002 03:10:12 -0700

   Reducing NR_CPUS from 32 to 2 reduces the kernel footprint by
   approximately 240 kilobytes.
   
Nice.  While you're at it can you fix the value on 64-bit
platforms when CONFIG_NR_CPUS is not specified?  (it should
be 64, not 32)
