Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278269AbRKHUw0>; Thu, 8 Nov 2001 15:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278286AbRKHUwJ>; Thu, 8 Nov 2001 15:52:09 -0500
Received: from web12202.mail.yahoo.com ([216.136.173.86]:1545 "HELO
	web12202.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S278269AbRKHUvp>; Thu, 8 Nov 2001 15:51:45 -0500
Message-ID: <20011108205144.60063.qmail@web12202.mail.yahoo.com>
Date: Thu, 8 Nov 2001 12:51:44 -0800 (PST)
From: Amit Kulkarni <amitncsu@yahoo.com>
Subject: __VERSIONED_SYMBOL and related EXPORT_SYMBOL error
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello everybody,

when i do a ksyms -a | grep skb_dump  (this symbol i
have added )
 i see 
some_addr  __VERSIONED_SYMBOL(skb_dump)
I think this is the reason it gives unresolved symbol
when I try to load a module that calls the function

>From a reply by Keith to a mail on the list earlier I
gather that this is coaused because the dev.c where
this symbol is  defined is implicitly included via

obj-$(CONFIG_NET) += dev.o dev_mcast.o 

There was no followup on what needs to be done  on
that thread .
I guess the sender was an intelligent person   :(
Can Somebody please tell me  what I need to do to
resolve this. I am trying to export a  few other
symbols but  they do not even get added to /proc/ksyms



please advise 

Regards,
amit
 

__________________________________________________
Do You Yahoo!?
Find a job, post your resume.
http://careers.yahoo.com
