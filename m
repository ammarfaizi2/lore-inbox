Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285197AbRLFVEh>; Thu, 6 Dec 2001 16:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285218AbRLFVEa>; Thu, 6 Dec 2001 16:04:30 -0500
Received: from pizda.ninka.net ([216.101.162.242]:10635 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S285201AbRLFVCu>;
	Thu, 6 Dec 2001 16:02:50 -0500
Date: Thu, 06 Dec 2001 13:02:02 -0800 (PST)
Message-Id: <20011206.130202.107681970.davem@redhat.com>
To: lm@bitmover.com
Cc: phillips@bonn-fries.net, davidel@xmailserver.org, rusty@rustcorp.com.au,
        Martin.Bligh@us.ibm.com, riel@conectiva.com.br, lars.spam@nocrew.org,
        alan@lxorguk.ukuu.org.uk, hps@intermeta.de,
        linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011206122116.H27589@work.bitmover.com>
In-Reply-To: <20011206121004.F27589@work.bitmover.com>
	<20011206.121554.106436207.davem@redhat.com>
	<20011206122116.H27589@work.bitmover.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Larry McVoy <lm@bitmover.com>
   Date: Thu, 6 Dec 2001 12:21:16 -0800
   
   You tell me - which is easier, multithreading the networking stack to 
   64 way SMP or running 64 distinct networking stacks?

We've done %90 of the "other stuff" already, why waste the work?
We've done the networking, we've done the scheduler, and the
networking/block drivers are there too.

I was actually pretty happy with how easy (relatively) the networking
was to thread nicely.

The point is, you have to make a captivating argument for ccClusters,
what does it buy us now that we've done a lot of the work you are
telling us it will save?
