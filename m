Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281892AbRKXFjO>; Sat, 24 Nov 2001 00:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282262AbRKXFjE>; Sat, 24 Nov 2001 00:39:04 -0500
Received: from femail34.sdc1.sfba.home.com ([24.254.60.24]:25481 "EHLO
	femail34.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S281892AbRKXFix>; Sat, 24 Nov 2001 00:38:53 -0500
Date: Fri, 23 Nov 2001 23:38:57 -0600
From: Anton Petrusevich <casus@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: threads & /proc
Message-ID: <20011123233857.A25084@casus.tx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guys,

Well, I'm a bit surprised that nobody asked it yet. Do we have sound
thread support? I am able to put my linux-2.4.15-pre{1,7} --
definitely, and if I remember right, 2.4.14-pre{7,8} too in some strange
state, when any program like top, killall or ps that wanna get some
information from /proc (even midnight commander if you are trying to
look at state of any process) blocks indefinitely. It goes to unclean
shutdown, for example. kill doesn block, but do nothing. (I tried to
kill processes from ls /proc list). And I see it only after several
[unsuccessful] runs of my multithreaded program. Well, I can't say 
it's a correctly written program, I am still looking for bugs there. 
I don't have 100% way to get into this state, but I suspect some locking
issues with /proc. 
-- 
Anton
