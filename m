Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267243AbTA0RIm>; Mon, 27 Jan 2003 12:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267248AbTA0RIm>; Mon, 27 Jan 2003 12:08:42 -0500
Received: from mx2.elte.hu ([157.181.151.9]:42394 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S267243AbTA0RIl>;
	Mon, 27 Jan 2003 12:08:41 -0500
To: linux-kernel@vger.kernel.org
Subject: /proc problem
From: =?iso-8859-2?q?Burj=E1n_G=E1bor?= <buga@elte.hu>
Date: Mon, 27 Jan 2003 18:16:42 +0100
Message-ID: <yau1fucy2t.fsf@gizmo.elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Emacs Gnus
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've a mysterious problem with Linux kernels on a production system.
The box is a web frontend machine and the problem is that after a
couple of days of running one of httpd process "sticks" in.  Commands
w, ps and their friends usually hang after this case.  I cannot stat
the files under /proc/<PID-of-this-httpd-process>/, so I think this
should be a kernel-related problem.  Only the reboot helps.

I tried out a lot of kernel versions: 2.4.10, 2.4.19, 2.4.19rmap14b
(the last one with the new procfs code), but these didn't help.

Any idea?

  Buga
