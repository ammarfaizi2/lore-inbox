Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130875AbRAaSs3>; Wed, 31 Jan 2001 13:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130936AbRAaSsS>; Wed, 31 Jan 2001 13:48:18 -0500
Received: from cold.fortyoz.org ([64.40.111.214]:11790 "HELO cold.fortyoz.org")
	by vger.kernel.org with SMTP id <S130875AbRAaSsO>;
	Wed, 31 Jan 2001 13:48:14 -0500
Date: Wed, 31 Jan 2001 10:48:43 -0800
From: David Raufeisen <david@fortyoz.org>
To: linux-kernel@vger.kernel.org
Subject: procps stop working randomly (2.4.1)
Message-ID: <20010131104843.B13445@fortyoz.org>
Reply-To: David Raufeisen <david@fortyoz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-Operating-System: Linux 2.2.17 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Never seen this before but this morning 'ps' and the like randomly stopped
working..

david@prototype:~$ ps aux
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
david@prototype:~$ 
david@prototype:~$ uname -a
Linux prototype 2.4.1 #1 Tue Jan 30 01:45:38 PST 2001 i686 unknown
david@prototype:~$ uptime
 10:46am  up  7:25,  4 users,  load average: 0.02, 0.14, 0.09

But if I wait for a little bit and run it again it works, then stops working..
and so on.

Linux prototype 2.4.1 #1 Tue Jan 30 01:45:38 PST 2001 i686 unknown
Kernel modules         2.4.1
Gnu C                  2.95.3
Gnu Make               3.79.1
Binutils               2.10.1.0.2
Linux C Library        2.2.1
Dynamic linker         ldd (GNU libc) 2.2.1
Procps                 2.0.7
Mount                  2.10q
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         NVdriver

-- 
David Raufeisen <david@fortyoz.org>
Cell: (604) 818-3596
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
