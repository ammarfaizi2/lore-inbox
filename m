Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319781AbSIMUt4>; Fri, 13 Sep 2002 16:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319785AbSIMUt4>; Fri, 13 Sep 2002 16:49:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61900 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319781AbSIMUtz>;
	Fri, 13 Sep 2002 16:49:55 -0400
Date: Fri, 13 Sep 2002 13:46:27 -0700 (PDT)
Message-Id: <20020913.134627.20754727.davem@redhat.com>
To: akropel1@rochester.rr.com
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: Streaming DMA mapping question
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020913205241.GB22100@www.kroptech.com>
References: <20020913202150.GA24340@www.kroptech.com>
	<20020913.132842.97163812.davem@redhat.com>
	<20020913205241.GB22100@www.kroptech.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Adam Kropelin <akropel1@rochester.rr.com>
   Date: Fri, 13 Sep 2002 16:52:41 -0400

   > I think you're problems are elsewhere :-)
   
   Probably true, but the test machine I'm running on *is* SMP ppro ;)

If you add the write buffer flush to the pci_map_*() routines,
does it make your problem go away?
