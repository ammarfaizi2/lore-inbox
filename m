Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316935AbSFKITg>; Tue, 11 Jun 2002 04:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316951AbSFKITf>; Tue, 11 Jun 2002 04:19:35 -0400
Received: from pizda.ninka.net ([216.101.162.242]:18627 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316935AbSFKITe>;
	Tue, 11 Jun 2002 04:19:34 -0400
Date: Tue, 11 Jun 2002 01:15:25 -0700 (PDT)
Message-Id: <20020611.011525.29963495.davem@redhat.com>
To: oliver@neukum.name
Cc: roland@topspin.com, wjhun@ayrnetworks.com, paulus@samba.org,
        linux-kernel@vger.kernel.org
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200206111007.19142.oliver@neukum.name>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Oliver Neukum <oliver@neukum.name>
   Date: Tue, 11 Jun 2002 10:07:19 +0200
   
   Are there really PCI controllers which have to physically write
   much more than is transfered ?
   
On sparc64 the cacheline size can be either 64 or 128 bytes.
It's a bus characteristic, so we have to get at the PCI
controller info.
