Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292897AbSCFBVI>; Tue, 5 Mar 2002 20:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292879AbSCFBU6>; Tue, 5 Mar 2002 20:20:58 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:14497 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S292901AbSCFBUy>;
	Tue, 5 Mar 2002 20:20:54 -0500
Message-ID: <3C856EC4.5090505@us.ibm.com>
Date: Tue, 05 Mar 2002 17:20:04 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020227
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from ext2_get_block() version 2
In-Reply-To: <200203060023.g260NIB09974@localhost.localdomain> <E16iPdM-0004x1-00@the-village.bc.nu> <20020306004432.GC5538@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
 > Also, there seems to be a plan already in progress to do this on
 > 2.5.  BLK has been moved around in several filesystems to ease
 > transition to another lock.

As I indicated elsewhere in the thread, this _is_ a 2.5 backport
chosen because of the tremendous impact on BKL contention.

-- 
Dave Hansen
haveblue@us.ibm.com

