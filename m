Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264290AbTLVBzH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 20:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264292AbTLVBzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 20:55:07 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:32408 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S264290AbTLVByy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 20:54:54 -0500
Message-ID: <3FE64EEB.6090402@labs.fujitsu.com>
Date: Mon, 22 Dec 2003 10:54:51 +0900
From: Tsuchiya Yoshihiro <tsuchiya@labs.fujitsu.com>
Reply-To: tsuchiya@labs.fujitsu.com
Organization: Fujitsu Labs
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: filesystem bug?
References: <3FDD7DFD.7020306@labs.fujitsu.com>	 <1071582242.5462.1.camel@sisko.scot.redhat.com> <3FDF7BE0.205@jpl.nasa.gov>	 <3FDF95EB.2080903@labs.fujitsu.com>  <3FE0E5C6.5040008@labs.fujitsu.com> <1071782986.3666.323.camel@sisko.scot.redhat.com> <3FE62999.90309@labs.fujitsu.com>
In-Reply-To: <3FE62999.90309@labs.fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The problems I had seen with my script are followings:

1. disk inode is filled by 0.
2. disk inode is written by deleted inode.
3. a directory is gone during and after the test.
4. a directory is gone during the test, but it actually
exists after the test. (test script says "no such file or dir",
but when I see the directory, it is there.)
5. file data is destroyed.

Problem #1 to #3 happened both on ext2 and ext3.
#5 only on ext2 and #4 only on ext3.



Thanks,
Yoshi

--
Yoshihiro Tsuchiya


