Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262805AbSIPT4C>; Mon, 16 Sep 2002 15:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262957AbSIPT4C>; Mon, 16 Sep 2002 15:56:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:15846 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262805AbSIPT4B>;
	Mon, 16 Sep 2002 15:56:01 -0400
Date: Mon, 16 Sep 2002 12:52:11 -0700 (PDT)
Message-Id: <20020916.125211.82482173.davem@redhat.com>
To: linux-kernel@vger.kernel.org, todd-lkml@osogrande.com
Cc: hadi@cyberus.ca, tcw@tempest.prismnet.com, netdev@oss.sgi.com,
       pfeather@cs.unm.edu
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0209160805360.7184-100000@gp>
References: <20020913.150439.27187393.davem@redhat.com>
	<Pine.LNX.4.44.0209160805360.7184-100000@gp>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: todd-lkml@osogrande.com
   Date: Mon, 16 Sep 2002 08:16:47 -0600 (MDT)

   are there any standards in progress to support this.

Your question makes no sense, it is a hardware optimization
of an existing standard.  The chip merely is told what flows
exist and it concatenates TCP data from consequetive packets
for that flow if they arrive in sequence.
   
   who is working on this architecture for receives?

Once cards with the feature exist, probably Alexey and myself
will work on it.

Basically, who ever isn't busy with something else once the technology
appears.
   
   is there a beginning implementation yet of zerocopy receives

No.
   
Franks a lot,
David S. Miller
davem@redhat.com
