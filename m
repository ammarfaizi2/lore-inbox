Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285169AbRLRVJN>; Tue, 18 Dec 2001 16:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285166AbRLRVJE>; Tue, 18 Dec 2001 16:09:04 -0500
Received: from pizda.ninka.net ([216.101.162.242]:42130 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S285161AbRLRVI6>;
	Tue, 18 Dec 2001 16:08:58 -0500
Date: Tue, 18 Dec 2001 13:08:09 -0800 (PST)
Message-Id: <20011218.130809.22018359.davem@redhat.com>
To: acme@conectiva.com.br
Cc: SteveW@ACM.org, jschlst@samba.org, ncorbic@sangoma.com, eis@baty.hanse.de,
        dag@brattli.net, torvalds@transmeta.com, marcelo@conectiva.com.br,
        netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC 2] cleaning up struct sock
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011218185200.A1211@conectiva.com.br>
In-Reply-To: <20011218033552.B910@conectiva.com.br>
	<20011217.225134.91313099.davem@redhat.com>
	<20011218185200.A1211@conectiva.com.br>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
   Date: Tue, 18 Dec 2001 18:52:00 -0200

   Em Mon, Dec 17, 2001 at 10:51:34PM -0800, David S. Miller escreveu:
   > Which brings me to...
   >    
   >    Please let me know if this is something acceptable for 2.5.
   > 
   > What kind of before/after effect do you see in lat_tcp/lat_connect
   > (from lmbench) runs?
   
   Improvements on the lat_connect case? :)
   
Great.  I have no fundamental problems with your changes.

Now, when/if we move the hash-chain/identity members into
the IPv4 struct (there are some issues with this wrt. ipv6 btw) I will
be interested in seeing the same tests done :-)
