Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318795AbSIPE1M>; Mon, 16 Sep 2002 00:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318798AbSIPE1M>; Mon, 16 Sep 2002 00:27:12 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32991 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318795AbSIPE1L>;
	Mon, 16 Sep 2002 00:27:11 -0400
Date: Sun, 15 Sep 2002 21:23:21 -0700 (PDT)
Message-Id: <20020915.212321.64867280.davem@redhat.com>
To: hadi@cyberus.ca
Cc: linux-kernel@vger.kernel.org, todd-lkml@osogrande.com,
       tcw@tempest.prismnet.com, netdev@oss.sgi.com, pfeather@cs.unm.edu
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.GSO.4.30.0209151053530.22001-100000@shell.cyberus.ca>
References: <20020913.150439.27187393.davem@redhat.com>
	<Pine.GSO.4.30.0209151053530.22001-100000@shell.cyberus.ca>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: jamal <hadi@cyberus.ca>
   Date: Sun, 15 Sep 2002 16:16:13 -0400 (EDT)

   Your proposal does make sense although compute power would still be
   a player. I think the key would be parallelization;

Oh I forgot to mention that some of these cards also compute a cookie
for you on receive packets, and your meant to point the input
processing for that packet to a cpu whose number is derived from that
cookie it gives you.

Lockless per-cpu packet input queues make this sort of hard for us
to implement currently.
