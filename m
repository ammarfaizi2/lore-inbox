Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289959AbSAWSke>; Wed, 23 Jan 2002 13:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289961AbSAWSkY>; Wed, 23 Jan 2002 13:40:24 -0500
Received: from pizda.ninka.net ([216.101.162.242]:13185 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289959AbSAWSkN>;
	Wed, 23 Jan 2002 13:40:13 -0500
Date: Wed, 23 Jan 2002 10:38:33 -0800 (PST)
Message-Id: <20020123.103833.35505971.davem@redhat.com>
To: acahalan@cs.uml.edu
Cc: wli@holomorphy.com, vda@port.imtp.ilyichevsk.odessa.ua,
        linux-kernel@vger.kernel.org, andrea@suse.de, alan@redhat.com,
        akpm@zip.com.au, vherva@niksula.hut.fi
Subject: Re: Athlon/AGP issue update
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200201231709.g0NH9em421753@saturn.cs.uml.edu>
In-Reply-To: <20020123.034755.104030619.davem@redhat.com>
	<200201231709.g0NH9em421753@saturn.cs.uml.edu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
   Date: Wed, 23 Jan 2002 12:09:40 -0500 (EST)

   > Yes there most certainly are.  The driver's MMAP method can fully edit
   > the page protection attributes for that mmap area as it pleases.
   
   That doesn't help for MAP_ANON pages.

But it helps _THIS_ case, DRM(dma_mmap) is where all AGP memory comes
from and we can control the page protections for every page there.

If you want to start a thread about controlling cacheability
generically from mmap() or whatever idea you have, please
start a different thread and change the Subject.
