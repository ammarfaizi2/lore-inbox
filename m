Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbTI2PRX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 11:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263545AbTI2PRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 11:17:23 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:59370 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263544AbTI2PRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 11:17:19 -0400
Message-ID: <3F784AE9.4040906@nortelnetworks.com>
Date: Mon, 29 Sep 2003 11:08:25 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
Cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Bernardo Innocenti <bernie@develer.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Linux 2.6.0-test6
References: <Pine.LNX.4.44.0309281213240.4929-100000@callisto> <Pine.LNX.4.44.0309281035370.6307-100000@home.osdl.org> <20030928184642.GA1681@mars.ravnborg.org> <20030928191622.GA16921@wohnheim.fh-wedel.de> <20030928204224.G1428@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

> If a header has something like these:
> 
> struct my_headers_struct {
> 	struct task_struct *tsk;
> };
> 
> void my_function(struct task_struct *tsk);
> 
> and gcc warns that "struct task_struct" has not been declared, please
> don't think about adding another header.  Just declare the structure
> in the header file which needs it like this:
> 
> struct task_struct;

If I do that, make a change to task_struct, then run make, will the file 
get rebuilt?

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

