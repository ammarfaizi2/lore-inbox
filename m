Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132833AbRDIT5e>; Mon, 9 Apr 2001 15:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132835AbRDIT5W>; Mon, 9 Apr 2001 15:57:22 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30737 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132833AbRDIT5S>; Mon, 9 Apr 2001 15:57:18 -0400
Subject: Re: Processes hanging in D state in 2.4.3 - any findings?
To: eparis@andrew.cmu.edu (Eloy A. Paris)
Date: Mon, 9 Apr 2001 20:59:25 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010409114828.A25594@antenas> from "Eloy A. Paris" at Apr 09, 2001 11:48:28 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14mhot-0002nm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have seen several messages posted to l-k about people reporting
> processes (mozilla most of the time) hanging in the D state in 2.4.3,
> but I haven't seen someone posting a possible explanation or solution 
> to the problem.
> Anyone knows where does the problem lie, or a workaround for the
> problem? I hate going through the fsck that happens when umount fails
> because processes are in the D state...

2.2.19 or wait for 2.4.4pre soon to fix the semaphore problem that causes
this
