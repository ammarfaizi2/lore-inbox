Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136144AbRD0SIk>; Fri, 27 Apr 2001 14:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136148AbRD0SIa>; Fri, 27 Apr 2001 14:08:30 -0400
Received: from oe66.law11.hotmail.com ([64.4.16.201]:24585 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S136144AbRD0SIR>;
	Fri, 27 Apr 2001 14:08:17 -0400
X-Originating-IP: [12.19.166.64]
From: "Dan Mann" <daniel_b_mann@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: preset performance options in make config
Date: Fri, 27 Apr 2001 14:07:16 -0400
MIME-Version: 1.0
Content-Type: text/plain;	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Message-ID: <OE66ONfGAq3jGd2vtXS0000460d@hotmail.com>
X-OriginalArrivalTime: 27 Apr 2001 18:08:11.0748 (UTC) FILETIME=[0572DA40:01C0CF45]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was wondering if having a make config option with 3 or 4 choices for
general performance settings would be an option for the kernel?

Like maybe the first question would read something like:

Configure Preset Performance Options? (Y/N) Y
                Configure as Database Server (Y/N) N
                Configure as Web Server (Y/N)  N
                Configure as File & Print Server (Y/N) N
                Configure as Desktop Workstation (Y/N) Y


If you choose no at the first level you would get the standard vanilla
kernell.  If you choose Database Server Y, you would have some compile time
options set for you that make sense for a Data base server, like maybe vm
and cache settings or something like that.  If you choose Desktop
Workstation, you would get some compile time options that would increase
graphics performance, interactivity/latency or whatever. And likewise, if
you choose File & Print, you might get things that would make a desktop user
cringe performance wise, but really accelerate the machine in a server
environment.

This might be really complicated or easy...I don't know.  But I was reading
some Linux performance tuning stuff that talked about tweaking stuff in
/proc, and I figured that stuff starts out at a predefined base in the
source code.  There are tools out there that can work with /proc and help
tune, but they can't change things that are only available BEFORE the binary
is built. Maybe also things like different versions of scheduler or you know
like a schedule_database.c or a schedule_workstation.c, or a vm or disk
version of the same thing?

I know I might be way off base here...someone tell me if I am :-)....but
from my angle (non-programming guru) it might make a difference in the way
that linux performs for the average user/administrator.

What do you think?  Maybe help for someone who is looking to get the most
perf out of his/her system but maybe doesn't understand src code directly?

Dan

PS - Does anyone have any ideas about NT's kernel config before compile?
when you buy server is the kernel identical to workstation, with only
userland tweaks for performance?  Or are there deep source code level
changes between the two?  I'm sure since the code isn't out there no one
knows for sure, but does anyone even have an opinion on this matter?
