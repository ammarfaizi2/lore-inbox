Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264903AbSL0LaL>; Fri, 27 Dec 2002 06:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264907AbSL0LaL>; Fri, 27 Dec 2002 06:30:11 -0500
Received: from mail.msiu.ru ([62.117.90.7]:15116 "EHLO www.msiu.ru")
	by vger.kernel.org with ESMTP id <S264903AbSL0LaK>;
	Fri, 27 Dec 2002 06:30:10 -0500
Date: Fri, 27 Dec 2002 14:35:24 +0300
From: Point Free <shygin@mail.msiu.ru>
To: "Joseph" <jospehchan@yahoo.com.tw>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [USB 2.0 problem] ASUS CD-RW cannot be mounted.
Message-Id: <20021227143524.659c6595.shygin@mail.msiu.ru>
In-Reply-To: <004e01c2ad85$d9eeb2b0$3716a8c0@taipei.via.com.tw>
References: <002801c2acd2$edf6a870$3716a8c0@taipei.via.com.tw>
	<20021226174653.GA8229@kroah.com>
	<003d01c2ad4a$54eb09f0$3716a8c0@taipei.via.com.tw>
	<3E0BC155.5B291F57@eyal.emu.id.au>
	<004e01c2ad85$d9eeb2b0$3716a8c0@taipei.via.com.tw>
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i386-redhat-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At Fri, 27 Dec 2002 16:55:19 +0800
"Joseph" <jospehchan@yahoo.com.tw> wrote:

> > Check that you actually have /dev/scd0. I think it should be:
> > # mknod /dev/scd0 b 11 0
> > 
>  I've checked the node as follows.
> #ls -l /dec/scd0
> brw-r----- 1 root  disk 11,  0 Sep 9 13:24 /dev/scd0
> 

Ouh, could you post your /proc/devices ?
