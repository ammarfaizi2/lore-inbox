Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129166AbQKCOxw>; Fri, 3 Nov 2000 09:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129129AbQKCOxm>; Fri, 3 Nov 2000 09:53:42 -0500
Received: from westgate.starhub.net.sg ([203.116.1.190]:43787 "EHLO
	westgate.starhub.net.sg") by vger.kernel.org with ESMTP
	id <S129042AbQKCOxY>; Fri, 3 Nov 2000 09:53:24 -0500
Message-ID: <3A02D150.E7E87398@usa.net>
Date: Fri, 03 Nov 2000 22:53:04 +0800
From: Michael Boman <michael.boman@usa.net>
Organization: Eleventh Alliance
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ext3 vs. JFS file locations...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gurus,

I was trying to build a super-big kernel with allot of Journaling File
System inside it to try out what is best for us to use. Now, I
encountered a problem..

It seems like both IBM's JFS and ext3 wants to use fs/jfs .. IMHO that
is like asking for problem.. A more logic location for ext3 should be
fs/ext3, no?

Anyway, just my thought... It might already been discussed for what I
know.. 

BTW.. If you find time to reply on this post, please put me on the Cc:
line - I am not on the mailinglist, generates too much mail I have no
time to read...

Best regards
 Michael Boman

PS
 I was using 2.2.17 as base for my patches..
DS

-- 
Pager : out of order          | On the contrary of what you may
Mobile: (+65) 98 55 17 34     | think, your hacker is fully aware
eMail : michael.boman@usa.net | of your company's dress code. He
ICQ   : 5566009               | is fully aware of the fact that it
Handle: proxy / 11 Alliance   | doesn't help him to do his job.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
