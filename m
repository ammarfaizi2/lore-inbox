Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313592AbSDZCwr>; Thu, 25 Apr 2002 22:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313596AbSDZCwq>; Thu, 25 Apr 2002 22:52:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:43414 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S313592AbSDZCwq>;
	Thu, 25 Apr 2002 22:52:46 -0400
Date: Thu, 25 Apr 2002 19:43:01 -0700 (PDT)
Message-Id: <20020425.194301.90782367.davem@redhat.com>
To: terje.eggestad@scali.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible bug with UDP and SO_REUSEADDR. Was Re: [PATCH]
 zerocopy NFS updated
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1019738265.7409.1100.camel@pc-16.office.scali.no>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Terje Eggestad <terje.eggestad@scali.com>
   Date: 25 Apr 2002 14:37:44 +0200

   However writing a test server that stand in blocking wait on a UDP
   socket, and start two instances of the server it's ALWAYS the server
   last started that get the udp message, even if it's not in blocking
   wait, and the first started server is. 
   
   Smells like a bug to me, this behavior don't make much sence. 
   
   Using stock 2.4.17.

Can you post your test server/client application so that I
don't have to write it myself and guess how you did things?

Thanks.
