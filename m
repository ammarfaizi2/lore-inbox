Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314281AbSEHN5W>; Wed, 8 May 2002 09:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314292AbSEHN5V>; Wed, 8 May 2002 09:57:21 -0400
Received: from pizda.ninka.net ([216.101.162.242]:8361 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314281AbSEHN5U>;
	Wed, 8 May 2002 09:57:20 -0400
Date: Wed, 08 May 2002 06:45:28 -0700 (PDT)
Message-Id: <20020508.064528.27619995.davem@redhat.com>
To: dipankar@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockfree rtcache lookup using RCU
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020508185457.I10505@in.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Dipankar Sarma <dipankar@in.ibm.com>
   Date: Wed, 8 May 2002 18:54:57 +0530
   
   A large number of processes of which small sets may look up the same
   ip address. dst ip addresses change after every 50 packets or
   so.
   
   Is this more realistic ?

More like every 4 or 5 packets.
