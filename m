Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265549AbTGKTkd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 15:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265247AbTGKTjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 15:39:03 -0400
Received: from zeke.inet.com ([199.171.211.198]:16834 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id S265145AbTGKTh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 15:37:58 -0400
Message-ID: <3F0F1586.5090005@inet.com>
Date: Fri, 11 Jul 2003 14:52:38 -0500
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: .truncate function in filesystems
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

I'm rather at a loss to understand what .truncate is supposed to do when 
it _extends_ a file (2.5.68+ kernel).  Looking through the examples in 
the tree, I don't see where they deal with that case.  Could someone 
give me a clue as to how .truncate is supposed to...tell the kernel what 
blocks it is to use when it goes to read from the extended portion of 
the file?

So far, I have googled, grep'ed, looked at lwn.net, started in on 
linux.bkbits.net, emailed linux-fsdevel and kernel-newbies...  and I'm 
still not getting anywhere.  Even a basic explanation of how filesystems 
  deal/interact with buffer heads and inodes would probably help at this 
point.

Any clues or pointers or _anything_ would be very much appreciated. :/

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

