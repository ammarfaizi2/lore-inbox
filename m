Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314243AbSEITrr>; Thu, 9 May 2002 15:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314266AbSEITrq>; Thu, 9 May 2002 15:47:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:21687 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314243AbSEITrq>;
	Thu, 9 May 2002 15:47:46 -0400
Date: Thu, 09 May 2002 12:35:40 -0700 (PDT)
Message-Id: <20020509.123540.85382726.davem@redhat.com>
To: akpm@zip.com.au
Cc: indigoid@higherplane.net, dank@kegel.com, khttpd-users@alt.org,
        linux-kernel@vger.kernel.org
Subject: Re: khttpd rotten?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3CDACE73.6692A31E@zip.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@zip.com.au>
   Date: Thu, 09 May 2002 12:30:59 -0700

   The concern with moving one (major) application into the
   kernel is that this will weaken the testing/motivation to get
   zerocopy, aio and sophisticated notifications working well
   for userspace.
   
Actually, to the contrary, TUX was in fact an impetus for the
userlevel zerocopy and AIO bits :-)

I personally don't see anything wrong with something like the
TUX engine being in there.  At the same time I want to reiterate what
Ingo said which is what we can do in userspace catches up to what
TUX can do then we pull it out and move on to the next thing :-)

