Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268028AbTBWEfL>; Sat, 22 Feb 2003 23:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268029AbTBWEfL>; Sat, 22 Feb 2003 23:35:11 -0500
Received: from web9804.mail.yahoo.com ([216.136.129.214]:55427 "HELO
	web9804.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S268028AbTBWEfK>; Sat, 22 Feb 2003 23:35:10 -0500
Message-ID: <20030223044520.87268.qmail@web9804.mail.yahoo.com>
Date: Sat, 22 Feb 2003 20:45:20 -0800 (PST)
From: Tom Sanders <developer_linux@yahoo.com>
Subject: Question about Linux signal handling
To: redhat-list@redhat.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I catch a signal (SIGUSR2) using "sigaction" call
then is the signal handler replaced with default
handling, if I don't install the signal handler again?

I remember that in UNIX "signal" system call default
signal bahavior was to replace the signal handler with
default after everytime signal was received?

My observation is that even if I get same signal
twice, I get the same print (which I have in my signal
handler) again, illustrating that signal handler was
not replaced with default !!! Is that the correct
behavior of "sigaction"?

Thanks,
Tom

__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - forms, calculators, tips, more
http://taxes.yahoo.com/
