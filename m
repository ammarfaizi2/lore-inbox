Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312855AbSC0ADo>; Tue, 26 Mar 2002 19:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310517AbSC0ADe>; Tue, 26 Mar 2002 19:03:34 -0500
Received: from web13601.mail.yahoo.com ([216.136.175.112]:2828 "HELO
	web13601.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S312855AbSC0ADP>; Tue, 26 Mar 2002 19:03:15 -0500
Message-ID: <20020327000314.4430.qmail@web13601.mail.yahoo.com>
Date: Tue, 26 Mar 2002 16:03:14 -0800 (PST)
From: Balbir Singh <balbir_soni@yahoo.com>
Subject: Re: [PATCH] 2.5.7-dj1 remove global semaphore_lock spin lock.
To: Bob Miller <rem@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch seems nice, except for one thing,

I would like to see

add_wait_queue_exclusive_locked and
remove_wait_queue_locked as inline functions.

Comments,
Balbir


__________________________________________________
Do You Yahoo!?
Yahoo! Movies - coverage of the 74th Academy Awards®
http://movies.yahoo.com/
