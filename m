Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265366AbUAZAX4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 19:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265401AbUAZAX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 19:23:56 -0500
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:5552 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265366AbUAZAXz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 19:23:55 -0500
Date: Mon, 26 Jan 2004 01:23:56 +0100
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <aradorlinux@yahoo.es>
To: Andrew Morton <akpm@osdl.org>
Cc: bart@samwel.tk, felix-kernel@fefe.de, linux-kernel@vger.kernel.org
Subject: Re: Request: I/O request recording
Message-Id: <20040126012356.3a21ae18.aradorlinux@yahoo.es>
In-Reply-To: <20040125153803.4d7e1015.akpm@osdl.org>
References: <20040124181026.GA22100@codeblau.de>
	<20040124153551.24e74f63.akpm@osdl.org>
	<40144A36.5090709@samwel.tk>
	<20040125150914.1583d487.akpm@osdl.org>
	<4014516D.5070409@samwel.tk>
	<20040125153803.4d7e1015.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sun, 25 Jan 2004 15:38:03 -0800 Andrew Morton <akpm@osdl.org> escribió:

> Unfortunately you cannot determine a directory's blocks in this way. 
> Ext3's directories live in the /dev/hda1 pagecache anyway.  ext2's
> directories each have their own pagecache.

It would be possible to "hijack" the syscalls at libc level and look at what
the program is doing?
