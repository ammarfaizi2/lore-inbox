Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280106AbRJaItI>; Wed, 31 Oct 2001 03:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280107AbRJaIs6>; Wed, 31 Oct 2001 03:48:58 -0500
Received: from pizda.ninka.net ([216.101.162.242]:4737 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280106AbRJaIsq>;
	Wed, 31 Oct 2001 03:48:46 -0500
Date: Wed, 31 Oct 2001 00:49:19 -0800 (PST)
Message-Id: <20011031.004919.61505836.davem@redhat.com>
To: axboe@suse.de
Cc: dmaas@dcine.com, linux-kernel@vger.kernel.org
Subject: Re: SCSI tape crashes
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011031094650.H631@suse.de>
In-Reply-To: <20011031093353.F631@suse.de>
	<20011031.004311.85410732.davem@redhat.com>
	<20011031094650.H631@suse.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jens Axboe <axboe@suse.de>
   Date: Wed, 31 Oct 2001 09:46:50 +0100
   
   How is this different from my init_sg proposal? :-). The above looks
   fine to me, I just think it is important that we take care of this.
   
My impression was that you wanted to do something like:

	sgl = kmalloc();
	init_sg(sgl, nents);

	for_each_ent() {
		... existing code ..
	}

If what you really meant was semantically identicaly to what I have
proposed, I'm completely in agreement with it.  Please submit patches.

Franks a lot,
David S. Miller
davem@redhat.com

