Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132038AbRDGWEJ>; Sat, 7 Apr 2001 18:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132042AbRDGWD7>; Sat, 7 Apr 2001 18:03:59 -0400
Received: from [216.174.202.135] ([216.174.202.135]:37905 "EHLO
	celeborn.rivendell.insynq.com") by vger.kernel.org with ESMTP
	id <S132038AbRDGWDt>; Sat, 7 Apr 2001 18:03:49 -0400
From: Ian Eure <ieure@insynq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15055.36597.353681.125824@pyramid.insynq.com>
Date: Sat, 7 Apr 2001 15:04:37 -0700
To: linux-kernel@vger.kernel.org
Subject: loop problems continue in 2.4.3
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
X-Face: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i'm still having loopback problems with linux 2.4.3, even though they
were supposed to be fixed. it doesn't deadlock my maching right away
anymore, but instead causes a kernel panic after 4-6 uses of the loop
device.

the message i get is: "Kernel panic: Invalid blocksize passed to
set_blocksize"

100% reproducable. has anyone else seen this?

i did compile with gcc 2.92.3, and i have hedrick's ide patches
applied.

anyone else see this?

p.s. please cc: me in any replies, i'm not on the list.

-- 
 ___________________________________
| Ian Eure - <ieure@insynq.com>     | "You're living in a facist world...
|         -  Developer -            | Freedom is a luxury." -Front Line
|        -  InsynQ, Inc. -          | Assembly, "Digital Tension Dementia"
| Your Internet Utility Company.tm  |________________________________________
