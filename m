Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317003AbSFQUle>; Mon, 17 Jun 2002 16:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317006AbSFQUl2>; Mon, 17 Jun 2002 16:41:28 -0400
Received: from web13203.mail.yahoo.com ([216.136.174.188]:41222 "HELO
	web13203.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317003AbSFQUlZ>; Mon, 17 Jun 2002 16:41:25 -0400
Message-ID: <20020617204127.62122.qmail@web13203.mail.yahoo.com>
Date: Mon, 17 Jun 2002 13:41:27 -0700 (PDT)
From: "X.Xiao" <joyhaa@yahoo.com>
Subject: Dynamic Timer 
To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0206171321550.3236-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have two questions about dynamic timer in Linux:
1. Kernel space: After add_timer is used, where is the
code used to poll the global 'struct timer_list' to
activate the related functions on time? It's not in
sched.c, is it in tasklet/bh?
2. User space: is there a way to set a dynamic timer
in userspace as well, such as create_timer(posix, not
in Linux)? 

TIA

XH Xiao

__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com
