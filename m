Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317994AbSHZIKV>; Mon, 26 Aug 2002 04:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318007AbSHZIKV>; Mon, 26 Aug 2002 04:10:21 -0400
Received: from web40207.mail.yahoo.com ([66.218.78.68]:24070 "HELO
	web40207.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317994AbSHZIKU>; Mon, 26 Aug 2002 04:10:20 -0400
Message-ID: <20020826081431.44853.qmail@web40207.mail.yahoo.com>
Date: Mon, 26 Aug 2002 01:14:31 -0700 (PDT)
From: mike heffner <mdheffner@yahoo.com>
Subject: PROBLEM:  conflict between apm and system clock on Inspiron 8100
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  I have found a problem with the use of apm on my
dell inspiron 8100 running kernel 2.4.18-10.  Any
access to the apm kernel routine (for example cat
/proc/apm) causes the system clock to run slow.  About
1% slow if I run the battstat applet in gnome.  I
suspect that somehow the clock interrupt is getting
missed during the apm bios/kernel call.  Looking
though the apm.c I don't see how to fix this.  I tried
the switch apm=allow_int, but that showed no change. 
I have found some vague (don't mention apm) references
to this problem on the web, but no solutions.  Does
anyone understand this problem?

Thanks,
Mike
mdheffner@yahoo.com

__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com
