Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276650AbRJGXyI>; Sun, 7 Oct 2001 19:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276651AbRJGXx6>; Sun, 7 Oct 2001 19:53:58 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:4850 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S276650AbRJGXxr>; Sun, 7 Oct 2001 19:53:47 -0400
Message-ID: <3BC0EB11.31EA73C1@mvista.com>
Date: Sun, 07 Oct 2001 16:53:53 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steve Kieu <haiquy@yahoo.com>
CC: kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is there preempt patch for 2.2.19?
In-Reply-To: <20011007233220.73702.qmail@web10404.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Kieu wrote:
> 
> Hi,
> 
> I can not find it out but I hope some one would do
> that. Hope R. Love is willing to do that :-) , many
> thanks...
> 
Its not that it is hard to do, you might even get the current patch to
apply, more or less. 

The real problem is that it would not do you much good.  The 2.4.x work
removed a LOT of long held spinlocks and BKLs that the patch can not
(and does not in 2.4.x) fix.  Thus you would still have long latency
issues, even with the patch.

George
