Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319301AbSIFRj5>; Fri, 6 Sep 2002 13:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319303AbSIFRj5>; Fri, 6 Sep 2002 13:39:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:27526 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319301AbSIFRj4>;
	Fri, 6 Sep 2002 13:39:56 -0400
Date: Fri, 06 Sep 2002 10:37:17 -0700 (PDT)
Message-Id: <20020906.103717.82432404.davem@redhat.com>
To: gh@us.ibm.com
Cc: Martin.Bligh@us.ibm.com, hadi@cyberus.ca, tcw@tempest.prismnet.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, niv@us.ibm.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E17nMs2-0003F6-00@w-gerrit2>
References: <18563262.1031269721@[10.10.2.3]>
	<E17nMs2-0003F6-00@w-gerrit2>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Gerrit Huizenga <gh@us.ibm.com>
   Date: Fri, 06 Sep 2002 10:26:04 -0700
   
   One of our goals is to actually take the next generation of the most
   common "large system" web server and get it to scale along the lines
   of Tux or some of the other servers which are more common on the
   small machines.  For some reasons, big corporate customers want lots
   of features that are in a web server like apache and would also like
   the performance on their 8-CPU or 16-CPU machine to not suck at the
   same time.  High ideals, I know, wanting all features *and* performance
   from the same tool...  Next thing you know they'll want reliability
   or some such thing.

Why does Tux keep you from taking advantage of all the
feature of Apache?  Anything Tux doesn't handle in it's
fast path is simple fed up to Apache.
