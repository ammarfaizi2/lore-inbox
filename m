Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262215AbSIZHHT>; Thu, 26 Sep 2002 03:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262216AbSIZHHT>; Thu, 26 Sep 2002 03:07:19 -0400
Received: from pizda.ninka.net ([216.101.162.242]:13700 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262215AbSIZHHS>;
	Thu, 26 Sep 2002 03:07:18 -0400
Date: Thu, 26 Sep 2002 00:06:20 -0700 (PDT)
Message-Id: <20020926.000620.27781675.davem@redhat.com>
To: wli@holomorphy.com
Cc: axboe@suse.de, akpm@digeo.com, linux-kernel@vger.kernel.org,
       patman@us.ibm.com, andmike@us.ibm.com
Subject: Re: [PATCH] deadline io scheduler
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020926070615.GX22942@holomorphy.com>
References: <20020926064455.GC12862@suse.de>
	<20020926065951.GD12862@suse.de>
	<20020926070615.GX22942@holomorphy.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: William Lee Irwin III <wli@holomorphy.com>
   Date: Thu, 26 Sep 2002 00:06:15 -0700
   
   Hmm, qlogicisp.c isn't really usable because the disks are too
   slow, it needs bounce buffering, and nobody will touch the driver

I think it's high time to blow away qlogic{fc,isp}.c and put
Matt Jacob's qlogic stuff into 2.5.x
