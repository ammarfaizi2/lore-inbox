Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278715AbRJTB7A>; Fri, 19 Oct 2001 21:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278716AbRJTB6u>; Fri, 19 Oct 2001 21:58:50 -0400
Received: from mail11.speakeasy.net ([216.254.0.211]:7442 "EHLO
	mail11.speakeasy.net") by vger.kernel.org with ESMTP
	id <S278715AbRJTB6d>; Fri, 19 Oct 2001 21:58:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: swap with samba question using 2.4.12-ac3
Date: Fri, 19 Oct 2001 21:58:59 -0400
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011020015841Z278715-17408+2574@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, this is strange.   I'm stating about 3000 mp3s and they are on my linux 
box on a samba share.  Now this is on a 100mbit network so it's going at 
4+MB/s.   I started compiling avifile and i noticed that my swap usage was at 
105MB.   Not sure how it got that way as most of my ram (660MB) is being used 
as cache.   I'm not seeing any io so i'm guessing it's just mapped, not 
actually being used. 

My real question is:   is it possible to just give the value of swap actually 
being used as the swap use number? We have a breakdown of ram usage, but i 
dont know of any breakdown of swap usage ( actual use vs. mapped).  It's just 
a bit decieving when you glance at it and you see ram free 2MB swap use 105MB 
but then you realize that 87% of your ram is still being used as cache so you 
can't possibly be actually using 105MB of swap.   Heh.  smooth sailing though.
