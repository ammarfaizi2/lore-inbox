Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbTE3GMf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 02:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbTE3GMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 02:12:35 -0400
Received: from pizda.ninka.net ([216.101.162.242]:15277 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263295AbTE3GMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 02:12:34 -0400
Date: Thu, 29 May 2003 23:24:40 -0700 (PDT)
Message-Id: <20030529.232440.122068039.davem@redhat.com>
To: scrosby@cs.rice.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Algoritmic Complexity Attacks and 2.4.20 the dcache code
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <oyd3cixc9ev.fsf@bert.cs.rice.edu>
References: <oydbrxlbi2o.fsf@bert.cs.rice.edu>
	<1054267067.2713.3.camel@rth.ninka.net>
	<oyd3cixc9ev.fsf@bert.cs.rice.edu>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Scott A Crosby <scrosby@cs.rice.edu>
   Date: 30 May 2003 00:04:24 -0500
   
   Have you seen the current dcache function?
   
   /* Linux dcache */
   #define HASH_3(hi,ho,c)  ho=(hi + (c << 4) + (c >> 4)) * 11
   
Awesome, moving the Jenkins will actually save us some
cycles :-)
