Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267278AbTA0SnV>; Mon, 27 Jan 2003 13:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267280AbTA0SnV>; Mon, 27 Jan 2003 13:43:21 -0500
Received: from ns.suse.de ([213.95.15.193]:19211 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267278AbTA0SnU>;
	Mon, 27 Jan 2003 13:43:20 -0500
To: devnetfs <devnetfs@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel modules and 64-bit kernels
References: <20030127180414.85643.qmail@web20417.mail.yahoo.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 27 Jan 2003 19:52:38 +0100
In-Reply-To: devnetfs's message of "27 Jan 2003 19:05:18 +0100"
Message-ID: <p73n0lmzaq1.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

devnetfs <devnetfs@yahoo.com> writes:

> Do kernel modules need to be aware that they are running in a 64-bit
> kernel or a 32-bit kernel? 

Yes, if they want to support 32bit programs in a 64bit kernel they 
usually need ioctl translation and sometimes syscall translation
(if they have own ioctls or syscalls) 


> How should be the modules be written so they work both on 32/64-bit
> kernel AND can interact with both 32/64-bit userspace programs in
> a 64-bit kernel??

http://www.firstfloor.org/~andi/writing-ioctl32


-Andi
