Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286160AbRLTGDl>; Thu, 20 Dec 2001 01:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286159AbRLTGDP>; Thu, 20 Dec 2001 01:03:15 -0500
Received: from pizda.ninka.net ([216.101.162.242]:50307 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S286146AbRLTGBC>;
	Thu, 20 Dec 2001 01:01:02 -0500
Date: Wed, 19 Dec 2001 22:00:40 -0800 (PST)
Message-Id: <20011219.220040.55725223.davem@redhat.com>
To: bcrl@redhat.com
Cc: billh@tierra.ucsd.edu, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: aio
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011220005803.E3682@redhat.com>
In-Reply-To: <20011219224717.A3682@redhat.com>
	<20011219.213910.15269313.davem@redhat.com>
	<20011220005803.E3682@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Benjamin LaHaise <bcrl@redhat.com>
   Date: Thu, 20 Dec 2001 00:58:03 -0500
   
   Step back for a moment.  I know of phttpd and zeus.  They both have 
   a serious problem: they fall down when the load on the system exceeds 
   the capabilities of the cpu.  If you'd bother to take a look at the 
   aio api I'm proposing, it has less overhead under heavy load as events 
   get coalesced.  Even then, the overhead under light load is less than 
   signals or select or poll.

No I'm not talking about phttpd nor zeus, I'm talking about the guy
who did the hacks where he'd put the http headers + content into a
seperate file and just sendfile() that to the client.

I forget what his hacks were named, but there certainly was a longish
thread on this list about it about 1 year ago if memory serves.
