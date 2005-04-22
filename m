Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVDVWdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVDVWdw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 18:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVDVWdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 18:33:51 -0400
Received: from rutherford.zen.co.uk ([212.23.3.142]:25996 "EHLO
	rutherford.zen.co.uk") by vger.kernel.org with ESMTP
	id S261249AbVDVWdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 18:33:43 -0400
Message-ID: <42697BAE.9020902@southline.net>
Date: Fri, 22 Apr 2005 23:33:18 +0100
From: Graham Seale <graham@southline.net>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6 kernel, 2.4 kernel, keyboard input handling
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-Rutherford-IP: [82.69.89.195]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello kernel developers

Please forgive this format, which cannot conform to your standard bug 
reporting system because of its hardware sensitive nature. It cannot 
allow a developer exact replication of the problem circumstance. I do 
not have close knowledge nor expertise with source codes and scripts 
involved. I can only report what I have now clearly perceived and 
verified, in the only way I know how. My experience of Linux is limited 
to trying out several distributions, and opting for a Stage1 compiled 
Gentoo, which now works.

For my examples, I refer specifically to..
kernel "linux-2.4.30/drivers/input/*" as mostly functional version.
Kernel "linux-2.6.11.7/drivers/input/*" as the version with problems.

Essentially, there is a fundamental difference in the way the 2.4 kernel 
manages keyboard and mouse inputs as compared to the 2.6 kernel which 
makes the system intolerant of temporary absence of expected inputs as 
occurs when KVM (thats Keyboard Mouse Video) hardware switchers are 
used. With the 2.6 kernel, there are many examples of mouse and keyboard 
problems that are cannot be always blamed on brand-specific hardware 
nonconformities.

The problems I describe occur with ALL distributions I have tried, when 
installed in hardware Pentium P3 (Coppermine) processor on ABIT VT6X4 
motherboard with 439.9Mb memory.  I am soon to try it with  AMD Athlon 
on ASUS AN78X .

This knowledge has been hard won! There can hardly be a less efficient 
way to begin to perceive that a problem is kernel-related than by doing 
Gentoo installs only to find the keyboard is suddenly useless on that PC 
when the switcher hardware is perfectly OK when switching between other 
Windows and Linux system computers.

I now have verified that ALL distributions I have tried, featuring the 
2.6 kernel are incapable of robust and flexible response to such switchers.
Please note that modern KVM switchers are built to artificially simulate 
the presence of a keyboard on the non-selected PC input because before 
XP, Windows computers were unable to tolerate keyboard disconnection.

The loss of keyboard function is independent of the environment, whether 
using GUI applications (various) or command line only.

The response of the 2.4 kernel is much more able to re-establish 
keyboard polling sync. Generally, as the Linux GUI is restored, there 
are random input states that might bring up the menu (unasked), and this 
will go away after one or two mouse clicks on the screen. If a "freeze" 
does happen, it may be cleared by switching away, then back to the Linux PC.

I understand that the system is pre-emptive multitasking, with a "user" 
space, a deeper "kernel" space, all policing access to real hardware 
instructions, and that the timeslice priorities are dynamically reworked 
by a special algorithm. I would not presume to delve into these without 
much more reading on my part. I would request that you help to bring my 
concern to the attention of those who created this code.

In my situation, as the 2.6 kernel becomes more widely adopted, so am I 
locked out from using and learning on the Linux PCs which have to share 
hardware with Windows users. It seems a pity that in this respect, the 
2.6 kernel cannot do what the 2.4 kernel could adequately manage.

Thank you for listening.
My regards
Graham Seale
graham@southline.net    (offline 01:00 to  08:00 UTC)
graham.seale@zen.co.uk   (this is 24 hour)
