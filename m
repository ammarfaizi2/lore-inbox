Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283698AbRLECg4>; Tue, 4 Dec 2001 21:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283699AbRLECgq>; Tue, 4 Dec 2001 21:36:46 -0500
Received: from pizda.ninka.net ([216.101.162.242]:41383 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S283698AbRLECgk>;
	Tue, 4 Dec 2001 21:36:40 -0500
Date: Tue, 04 Dec 2001 18:36:01 -0800 (PST)
Message-Id: <20011204.183601.22018455.davem@redhat.com>
To: lm@bitmover.com
Cc: Martin.Bligh@us.ibm.com, riel@conectiva.com.br, lars.spam@nocrew.org,
        alan@lxorguk.ukuu.org.uk, hps@intermeta.de,
        linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011204163646.M7439@work.bitmover.com>
In-Reply-To: <Pine.LNX.4.33L.0112042129160.4079-100000@imladris.surriel.com>
	<2457910296.1007480257@mbligh.des.sequent.com>
	<20011204163646.M7439@work.bitmover.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Larry McVoy <lm@bitmover.com>
   Date: Tue, 4 Dec 2001 16:36:46 -0800
   
   OK, so start throwing stones at this.  Once we have a memory model that
   works, I'll go through the process model.

What is the difference between your messages and spin locks?
Both seem to shuffle between cpus anytime anything interesting
happens.

In the spinlock case, I can thread out the locks in the page cache
hash table so that the shuffling is reduced.  In the message case, I
always have to talk to someone.
