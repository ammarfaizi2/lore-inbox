Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129126AbRC2WPz>; Thu, 29 Mar 2001 17:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129242AbRC2WPp>; Thu, 29 Mar 2001 17:15:45 -0500
Received: from web4303.mail.yahoo.com ([216.115.104.195]:15877 "HELO
	web4303.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129126AbRC2WPc>; Thu, 29 Mar 2001 17:15:32 -0500
Message-ID: <20010329221451.27582.qmail@web4303.mail.yahoo.com>
Date: Thu, 29 Mar 2001 14:14:51 -0800 (PST)
From: Jerry Hong <jhong001@yahoo.com>
Subject: how mmap() works?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
  mmap() creates a mmaped memory associated with a
physical file. If a process updates the mmaped memory,
Linux will updates the file "automatically". If this
is the case, why do we need msync()? If this is not
the case, what is the interval between 2 "WRITE" (IO
request operation) request to the physical file
because it really updates the physical file somehow
even without msync().
  Any comments about how mmap() works will be
appreciated.
  Thanks.
  
  Jerry
  

__________________________________________________
Do You Yahoo!?
Get email at your own domain with Yahoo! Mail. 
http://personal.mail.yahoo.com/?.refer=text
