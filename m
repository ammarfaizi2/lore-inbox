Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268224AbTBNGze>; Fri, 14 Feb 2003 01:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268229AbTBNGze>; Fri, 14 Feb 2003 01:55:34 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:6786 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S268224AbTBNGze>; Fri, 14 Feb 2003 01:55:34 -0500
Message-ID: <3E4C9617.5070508@kegel.com>
Date: Thu, 13 Feb 2003 23:09:11 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: re: Synchronous signal delivery..
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus wrote:
 > fd = sigfd(sigset_t * mask, unsigned long flags);

Damn.  I got the interface wrong.  I guessed it would be
    int sigopen(int signum);
when I wrote the man page...
    http://www.uwsg.iu.edu/hypermail/linux/kernel/0106.3/0404.html

- Dan

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

