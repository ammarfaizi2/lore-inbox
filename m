Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277171AbRJDIN0>; Thu, 4 Oct 2001 04:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277172AbRJDINQ>; Thu, 4 Oct 2001 04:13:16 -0400
Received: from [195.66.192.167] ([195.66.192.167]:59147 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S277171AbRJDINA>; Thu, 4 Oct 2001 04:13:00 -0400
Date: Thu, 4 Oct 2001 11:12:16 +0200
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <1049487201.20011004111216@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: Bloatware (was Re: Security question: "Text file busy"...)
In-Reply-To: <m14rpg0w4a.fsf@frodo.biederman.org>
In-Reply-To: <Pine.GSO.4.21.0110040004430.26177-100000@weyl.math.psu.edu>
 <m14rpg0w4a.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thursday, October 04, 2001, 8:15:01 AM,
ebiederm@xmission.com (Eric W. Biederman) wrote:

EWB> I have days when I'm frustrated by the size of both glibc and the
EWB> linux kernel.  stripped both the linux kernel and glibc are comparable
EWB> in size.  Though I think the 400KB of compressed glibc-2.1.2 is
EWB> actually smaller than the kernel for the most part.  I have to strip
EWB> off practically everthing to get a useable bzImage under 400KB.

EWB> So any good ideas on how to get the size of linux down?

I think code quality priorities are:

1. Features
   If a program misses some very useful (or even vital)
   feature, there's not much sense in using it.
2. Stability
   Nobody likes when program (or server) hangs/crashes.
3. Speed
   Developers usually have fast machines with big disks,
   so they really like to see progs work fast.
4. Size

As you see, size isn't a top prio. It's sad, but we can't
have all these objectives met with same level of success.
However, Linux isn't that bad compared to Win2K nightmare.

And please let's not start a longish discussion on this. Please.
A contest to cut the most kbytes without loss of features/speed
from kernel/glibs/X/... is much more productive.  :-)

If you can't resist, may I suggest private mail, not lkml
-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua


