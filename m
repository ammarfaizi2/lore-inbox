Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317343AbSGOFqf>; Mon, 15 Jul 2002 01:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317342AbSGOFqe>; Mon, 15 Jul 2002 01:46:34 -0400
Received: from pizda.ninka.net ([216.101.162.242]:16579 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317341AbSGOFqd>;
	Mon, 15 Jul 2002 01:46:33 -0400
Date: Sun, 14 Jul 2002 22:40:06 -0700 (PDT)
Message-Id: <20020714.224006.75204590.davem@redhat.com>
To: ja@ssi.bg
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [BUG?] unwanted proxy arp in 2.4.19-pre10
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0207142213210.1343-100000@u.domain.uli>
References: <Pine.LNX.4.44.0207142213210.1343-100000@u.domain.uli>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Julian Anastasov <ja@ssi.bg>
   Date: Sun, 14 Jul 2002 22:35:04 +0000 (GMT)
   
   	can you explain what kind of control will be
   possible with arptables.

arptables can filter both incoming and outgoing ARP packets.
There are no limitations, it is perfectly generic.
