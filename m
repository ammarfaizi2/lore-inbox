Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288326AbSACWPW>; Thu, 3 Jan 2002 17:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288328AbSACWPN>; Thu, 3 Jan 2002 17:15:13 -0500
Received: from port29.ds1-rdo.adsl.cybercity.dk ([212.242.196.94]:11058 "HELO
	xyzzy.adsl.dk") by vger.kernel.org with SMTP id <S288326AbSACWPI>;
	Thu, 3 Jan 2002 17:15:08 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: The CURRENT macro
In-Reply-To: <20020103213455.34699.qmail@web14911.mail.yahoo.com>
X-Home-Page: http://peter.makholm.net/
Xyzzy: Nothing happens!
From: Peter Makholm <peter@makholm.net>
Date: Thu, 03 Jan 2002 23:14:59 +0100
In-Reply-To: <20020103213455.34699.qmail@web14911.mail.yahoo.com>
 (mylinuxk@yahoo.ca's message of "Thu, 3 Jan 2002 21:36:53 +0000 (UTC)")
Message-ID: <87u1u3ozdo.fsf@xyzzy.adsl.dk>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.4 (Artificial
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mylinuxk@yahoo.ca (Michael Zhu) writes:

> blk_dev[MAJOR_NR].request_queue". I know CURRENT is
> just a macro. Where can I find the definition of this
> macro?

Seek, and ye shall find (Matt 7.7):

xyzzy% find -type f | xargs grep "#define CURRENT "
./include/linux/blk.h:#define CURRENT blkdev_entry_next_request(&blk_dev[MAJOR_NR].request_queue.queue_head)
xyzzy%     

-- 
Når folk spørger mig, om jeg er nørd, bliver jeg altid ilde til mode
og svarer lidt undskyldende: "Nej, jeg bruger RedHat".
                                -- Allan Olesen på dk.edb.system.unix
