Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269959AbRHNB1d>; Mon, 13 Aug 2001 21:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269960AbRHNB1X>; Mon, 13 Aug 2001 21:27:23 -0400
Received: from web14606.mail.yahoo.com ([216.136.224.86]:49930 "HELO
	web14606.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S269959AbRHNB1D>; Mon, 13 Aug 2001 21:27:03 -0400
Message-ID: <20010814012712.86253.qmail@web14606.mail.yahoo.com>
Date: Mon, 13 Aug 2001 18:27:12 -0700 (PDT)
From: cardhore <cardhore@yahoo.com>
Subject: Control + Shift causes strange behavior in 2.4.8 & 2.4.7
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*Please CC all responses to cardhore@yahoo.com as I am
not subscribed.

When I hit both control keys _and_ both shift keys
simultaneously (you have to kind of hit them rapidly a
bunch of times) ONLY on my Microsoft natural keyboard,
the system hangs or prints various debug messages;
sometimes it locks up; the scroll lock comes on. 
Sometimes it releases, other times it locks and
requries a power cycle.  It does this in the console
and X-windows.  This is on a Microsoft PS/2 ergonomic
keyboard, on an Intel SE440BX motherbaord.  It does
not happen when I plug in a compaq USB keyboard, or
with another PS/2 keyboard.  The kernel is compiled
with GCC 2.95.3.


This kind of stuff is printed:
devfsd        S D6512000  6072   112      1          
126   105 (NOTLB)
Call Trace: [<c0150a96>] [<c012d906>] [<c0106b0b>]
cron          S D6485F8C  4740   126      1          
133   112 (NOTLB)
Call Trace: [<c01108bb>] [<c0110800>] [<c0119948>]
[<c0106b0b>]
gpm           S D6457F2C  4812   133      1          
134   126 (NOTLB)
Call Trace: [<c01108bb>] [<c0110800>] [<c013b301>]
[<c013b6a0>] [<c0106b0b>]
agetty        S 7FFFFFFF  4708   134      1          
136   133 (NOTLB)
Call Trace: [<c011085f>] [<c0177d9d>] [<c0173f08>]
[<c012d906>] [<c0106b0b>]
agetty        S 7FFFFFFF     0   136      1          
137   134 (NOTLB)
Call Trace: [<c011085f>] [<c0177d9d>] [<c0173f08>]
[<c012d906>] [<c0106b0b>]
agetty        S 7FFFFFFF     0   137      1          
138   136 (NOTLB)
Call Trace: [<c011085f>] [<c0177d9d>] [<c0173f08>]
[<c012d906>] [<c0106b0b>]
agetty        S 7FFFFFFF    48   138      1          
140   137 (NOTLB)
Call Trace: [<c011085f>] [<c0177d9d>] [<c0173f08>]
[<c012d906>] [<c0106b0b>]
agetty        S 7FFFFFFF     0   140      1          
281   138 (NOTLB)
Call Trace: [<c011085f>] [<c0177d9d>] [<c0173f08>]
[<c012d906>] [<c0106b0b>]
bash          S 00000004     0   281      1           
     140 (NOTLB)
Call Trace: [<c01782ca>] [<c017407c>] [<c01780e4>]
[<c012d9cb>] [<c0106b0b>]

What is going on?

__________________________________________________
Do You Yahoo!?
Send instant messages & get email alerts with Yahoo! Messenger.
http://im.yahoo.com/
