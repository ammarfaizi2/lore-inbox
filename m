Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317362AbSHGM6T>; Wed, 7 Aug 2002 08:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317521AbSHGM6T>; Wed, 7 Aug 2002 08:58:19 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:24535 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S317362AbSHGM6T>; Wed, 7 Aug 2002 08:58:19 -0400
Date: Wed, 7 Aug 2002 08:58:10 -0400 (EDT)
From: Bill Davidsen <bill@tmr.com>
Reply-To: <davidsen@tmr.com>
To: <linux-kernel@vger.kernel.org>
Subject: Threads and file open limits
Message-ID: <Pine.LNX.4.33.0208070855450.2426-100000@iccarus.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a server app which threads, and I note that all threads seem to
have all sockets open, which under load is likely to hit 1024 any evening.
Do I still have to edit limits.h? I ask because I note that root can
ulimit open files higer, and I thought the limit was hard in the kernel.

