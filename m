Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315998AbSEJNxy>; Fri, 10 May 2002 09:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315999AbSEJNxx>; Fri, 10 May 2002 09:53:53 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:16020 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S315998AbSEJNxx>; Fri, 10 May 2002 09:53:53 -0400
Message-ID: <3CDBC5A5.A1844CC0@nortelnetworks.com>
Date: Fri, 10 May 2002 09:05:41 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: how to redirect serial console to telnet session?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have an embedded box with serial console.  I have a debug version of a driver
that wants to dump so much stuff to console that the poor serial can't keep up
and I can't run other commands.

I would like to redirect the stream of stuff going to the console to a telnet
session over ethernet.

Accordingly, I grabbed what looked like the important bits of xconsole, but it
appears that this only gets me stuff written to /dev/console from userspace. 
How do I go about getting the output of kernel-level printk()s as well?

Thanks,

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
