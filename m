Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314468AbSEXPfx>; Fri, 24 May 2002 11:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317137AbSEXPfw>; Fri, 24 May 2002 11:35:52 -0400
Received: from ABordeaux-202-1-1-47.abo.wanadoo.fr ([217.128.241.47]:35456
	"EHLO buffy.mds") by vger.kernel.org with ESMTP id <S314468AbSEXPfv>;
	Fri, 24 May 2002 11:35:51 -0400
Message-ID: <3CEE5E96.7EA1D748@roulaise.net>
Date: Fri, 24 May 2002 17:39:02 +0200
From: "Frederic Lochon (crazyfred)" <lochon@roulaise.net>
Organization: http://www.crazyfred.org
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.17 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: hang. bug ? tcp.c recvmsg() 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

My kernel (2.4.17 with Usagi/Preempt/lm-sensors patches) has hang with
these kind of messages (from /var/log/messages):

kernel: recvmsg bug: copied 99564C37 seq 9956A67C
...
kernel: recvmsg bug: copied 99564C37 seq 0

I waited some minutes but had to reboot with the button because nothing
was responding.

I have reguraly the same (I suppose) hangs: I hear an access on a disk
(the one with /var/log) and it hangs. I suppose I've been lucky this
time since I have something in logs.

I've (allmost) never had anything in logs except this afternoon.
The last time I had something was on January 16th (same kernel, without
Usagi).

Here is the full log:
http://crazy.fred.free.fr/tmp/bug.txt

The log looks awful, it seems syslogs had some trouble..
It seems there is another message but maybe not very useful since it is
allmost unreadable.

I use:
- Linux 2.4.17 SMP on Abit BP6 (dual celeron) with 384MB RAM
- Usagi patch
- preempt patch
- lm-sensors patch
- gcc version 2.95.3 20010315 (release)
- binutils 2.11.2
- glibc 2.2.4

PS: please CC since I'm not on the list.

-- 
Frederic Lochon
