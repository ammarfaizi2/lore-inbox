Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280641AbRKSTY1>; Mon, 19 Nov 2001 14:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280646AbRKSTYS>; Mon, 19 Nov 2001 14:24:18 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:1015 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S280641AbRKSTYM>; Mon, 19 Nov 2001 14:24:12 -0500
Message-ID: <3BF95C48.C49B3AE1@mvista.com>
Date: Mon, 19 Nov 2001 11:23:52 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Memory allocation question
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I need (want) to allocate block of memory for POSIX timers in about page
size chuncks.  Currently I am using kmalloc() to allocate a page at a
time.  I don't want to have to worry about mapping/unmapping etc.  I
just what to go about using the memory.  It will be used for timers so
it must not be paged.  

Is kmalloc() the best interface to use or is there a better one?


-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
