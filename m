Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315921AbSGARYo>; Mon, 1 Jul 2002 13:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315928AbSGARYn>; Mon, 1 Jul 2002 13:24:43 -0400
Received: from smtp02.web.de ([217.72.192.151]:39440 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S315921AbSGARYl>;
	Mon, 1 Jul 2002 13:24:41 -0400
Date: Mon, 1 Jul 2002 19:26:59 +0200
From: Timo Benk <t_benk@web.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Timo Benk <t_benk@web.de>
Subject: allocate memory in userspace
Message-ID: <20020701172659.GA4431@toshiba>
Reply-To: Timo Benk <t_benk@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am a kernel newbie and i am writing a module. I 
need to allocate some memory in userspace because
i want to access syscalls like open(), lstat() etc.
I need to call these methods in the kernel, and in
my special case there is no other way, but i 
do not want to reimplement all the syscalls.

I read that it should be possible, but i cannot
find any example or recipe on how to do it.
It should work with do_mmap() and fd=-1 and
MAP_ANON, but i jusst can't get it to work.

Do you now any working example, or a good reference
for the do_mmap() call? 

Thanks in advance,

-timo

-- 
gpg key fingerprint = 6832 C8EC D823 4059 0CD1  6FBF 9383 7DBD 109E 98DC

