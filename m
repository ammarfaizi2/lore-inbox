Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317012AbSFKMIp>; Tue, 11 Jun 2002 08:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317013AbSFKMIo>; Tue, 11 Jun 2002 08:08:44 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61124 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317012AbSFKMIn>;
	Tue, 11 Jun 2002 08:08:43 -0400
Date: Tue, 11 Jun 2002 05:04:33 -0700 (PDT)
Message-Id: <20020611.050433.28184805.davem@redhat.com>
To: oliver@neukum.name
Cc: roland@topspin.com, wjhun@ayrnetworks.com, paulus@samba.org,
        linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200206111406.14274.oliver@neukum.name>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Oliver Neukum <oliver@neukum.name>
   Date: Tue, 11 Jun 2002 14:06:14 +0200
   
   A sparc64 is unlikely to be short on memory, or is it ?
   What's wrong with always aligning on 128 bytes on sparc64 ?
   A runtime check would be expensive.

Maybe on arch FOO, target X needs no alignment when using PCI
controller Y, but for PCI controller Z it does need alignment.
