Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264903AbSLGX0W>; Sat, 7 Dec 2002 18:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264892AbSLGX0W>; Sat, 7 Dec 2002 18:26:22 -0500
Received: from pizda.ninka.net ([216.101.162.242]:46466 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264901AbSLGX0V>;
	Sat, 7 Dec 2002 18:26:21 -0500
Date: Sat, 07 Dec 2002 15:30:45 -0800 (PST)
Message-Id: <20021207.153045.26640406.davem@redhat.com>
To: akpm@digeo.com
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [RFC][PATCH] net drivers and cache alignment
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3DF2844C.F9216283@digeo.com>
References: <20021207.144004.45605764.davem@redhat.com>
	<3DF27EE7.4010508@pobox.com>
	<3DF2844C.F9216283@digeo.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@digeo.com>
   Date: Sat, 07 Dec 2002 15:29:16 -0800

   Jeff Garzik wrote:
   > Attached is cut #2.  Thanks for all the near-instant feedback so far :)
   >   Andrew, does the attached still need padding on SMP?
   
   It needs padding _only_ on SMP.  ____cacheline_aligned_in_smp.
   
non-smp machines lack L2 caches?  That's new to me :-)

More seriously, there are real benefits on non-SMP systems.
