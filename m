Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287186AbRL2Mxi>; Sat, 29 Dec 2001 07:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287188AbRL2Mx2>; Sat, 29 Dec 2001 07:53:28 -0500
Received: from web20303.mail.yahoo.com ([216.136.226.84]:65084 "HELO
	web20303.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S287186AbRL2MxO>; Sat, 29 Dec 2001 07:53:14 -0500
Message-ID: <20011229125313.25113.qmail@web20303.mail.yahoo.com>
Date: Sat, 29 Dec 2001 04:53:13 -0800 (PST)
From: Amber Palekar <amber_palekar@yahoo.com>
Subject: additional bit in task & page struct
To: kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
 Hi...
    I want to add my own bit (a #define PG_MYBIT)
 similar to into the flags in task_struct as defined
 in linux v2.4.4 in sched.h which is defined as:
 
 unsigned long flag; /*per process flags */ 
 
    I want a free #define where I can define the
 process specific flag like PG_EXITING, PG_STARTING.
 
    Similarly, I also want to add my own bit into the
 flags in the _page struct_ wherein I can establish
 the state of a particular page.
   
    Using this my program wants to distinguish
 between some privileged pages of a process
 (privileged for my program which serves them..) from
 other processes and pages.
 
    Please tell me which #define can I use to do this
 in both the structures.
   
    Thanking you in advance,
  
 Amber
 


__________________________________________________
Do You Yahoo!?
Send your FREE holiday greetings online!
http://greetings.yahoo.com
