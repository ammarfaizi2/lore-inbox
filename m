Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbTJJQdw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 12:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263061AbTJJQdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 12:33:52 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:12497 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263060AbTJJQdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 12:33:50 -0400
Message-ID: <3F86DF4B.6020509@nortelnetworks.com>
Date: Fri, 10 Oct 2003 12:33:15 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Joel Becker <Joel.Becker@oracle.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
References: <Pine.LNX.4.44.0310100839030.20420-100000@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> I'm hoping in-memory databases will just kill off the current crop 
> totally. That solves all the IO problems - the only thing that goes to 
> disk is the log and the backups, and both go there totally linearly unless 
> the designer was crazy.

How does this play with massive (ie hundreds or thousands of gigabytes) 
databases?  Surely you can't expect to put it all in memory?

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

