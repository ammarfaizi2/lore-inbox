Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265323AbRFVDrl>; Thu, 21 Jun 2001 23:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265324AbRFVDrc>; Thu, 21 Jun 2001 23:47:32 -0400
Received: from [213.97.199.90] ([213.97.199.90]:13440 "HELO fargo")
	by vger.kernel.org with SMTP id <S265323AbRFVDrW> convert rfc822-to-8bit;
	Thu, 21 Jun 2001 23:47:22 -0400
From: "David Gomez" <davidge@jazzfree.com>
Date: Fri, 22 Jun 2001 05:44:41 +0200 (CEST)
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Comment in sched.c
Message-ID: <Pine.LNX.4.21.0106220530280.1168-100000@fargo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I know this is maybe stupid, but...

At the beggining of sched.c, this commentary appears:

/*
 * 'sched.c' is the main kernel file. It contains scheduling primitives
 * (sleep_on, wakeup, schedule etc) as well as a number of simple system
 * call functions (type getpid()), which just extract a field from
 * current-task
 */

Shouldn't be ommited the last part ? It has several system calls, but
sys_getpid is in timer.c, not in sched.c.



David Gómez



