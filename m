Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314077AbSE1Lk3>; Tue, 28 May 2002 07:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314078AbSE1Lk2>; Tue, 28 May 2002 07:40:28 -0400
Received: from pizda.ninka.net ([216.101.162.242]:8353 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314077AbSE1Lk1>;
	Tue, 28 May 2002 07:40:27 -0400
Date: Tue, 28 May 2002 04:25:14 -0700 (PDT)
Message-Id: <20020528.042514.92633856.davem@redhat.com>
To: dipankar@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 8-CPU (SMP) #s for lockfree rtcache
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020528171104.D19734@in.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Dipankar Sarma <dipankar@in.ibm.com>
   Date: Tue, 28 May 2002 17:11:04 +0530
   
   Here are the results in terms of profile counts in
   ip_route_output_key() - gc stands for neighbor table garbage
   collection adjustment and u2000 stands for 2ms packet
   rate delay. All measurements where done based on  2.5.3 kernel.

Thanks, I am convinced RCU is the way to go.

Once the generic RCU bits are in the 2.5.x tree, feel free to
send me your ipv4 routing cache changes.
