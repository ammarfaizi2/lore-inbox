Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318995AbSIJF2e>; Tue, 10 Sep 2002 01:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319039AbSIJF2e>; Tue, 10 Sep 2002 01:28:34 -0400
Received: from web40511.mail.yahoo.com ([66.218.78.128]:3250 "HELO
	web40511.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S318995AbSIJF2d>; Tue, 10 Sep 2002 01:28:33 -0400
Message-ID: <20020910053314.24891.qmail@web40511.mail.yahoo.com>
Date: Mon, 9 Sep 2002 22:33:14 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: Which HDIO_ command(s) to flush all data to disk
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to write a program that flushes all outstanding data to 
an IDE hard drive, including the write cache. Is it sufficient just
to write:

unsigned char args[4] = {WIN_FLUSH_CACHE,0,0,0};
ioctl(fd, HDIO_DRIVE_CMD, &args)

or do I need to worry about the buffer cache as well(WIN_WRITE_BUFFER?)

Thanks in advance.

__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com
