Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317898AbSGPRNg>; Tue, 16 Jul 2002 13:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317896AbSGPRNg>; Tue, 16 Jul 2002 13:13:36 -0400
Received: from chaos.analogic.com ([204.178.40.224]:6785 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317898AbSGPRNe>; Tue, 16 Jul 2002 13:13:34 -0400
Date: Tue, 16 Jul 2002 13:19:09 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: if_exist_pid()
Message-ID: <Pine.LNX.3.95.1020716131206.19310A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Anybody know the 'correct' way of determining if a pid still
exists?  I've been using "kill(pid, 0)" and, if it does not
return an error, it is supposed to exist. This is to release
a user-mode lock (semaphore) if the task that held the lock
crashed. Maybe there is a 'if_exist_pid(pid)' call somewhere?
Sending signal 0 to a pid sometimes returns 0, even if the pid
is long-gone and I don't want to read /proc to look for info.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

