Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315353AbSEBTAq>; Thu, 2 May 2002 15:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315355AbSEBTAp>; Thu, 2 May 2002 15:00:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:49374 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315353AbSEBTAo>;
	Thu, 2 May 2002 15:00:44 -0400
Date: Thu, 02 May 2002 11:49:32 -0700 (PDT)
Message-Id: <20020502.114932.126461178.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: dalecki@evision-ventures.com, arjanv@redhat.com, rgooch@ras.ucalgary.ca,
        linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E173Lzj-0004bc-00@the-village.bc.nu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Thu, 2 May 2002 20:11:59 +0100 (BST)

   > Yes I know. But my main point is that they maintain the
   > whole module symbol and dependency data entierly in user space
   
   Actually thats also incorrect as far as I can tell
   
To the best of my knowledge, they do something similar
to what modutils does right now when depmod is run, but
at module load time.  Ie. "oh module X needs symbol Y, who
provides symbol Y, lets load that first then retry X"
