Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbTEDPL4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 11:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263633AbTEDPL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 11:11:56 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:31752 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S263632AbTEDPLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 11:11:54 -0400
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: fcntl file locking and pthreads
Date: Sun, 4 May 2003 15:24:21 +0000 (UTC)
Organization: A poorly-maintained Debian GNU/Linux InterNetNews site
Message-ID: <b93bb5$n8v$1@news.cistron.nl>
References: <20030504125845.GA32087@mail.jlokier.co.uk> <Pine.LNX.4.33.0305040922020.32427-100000@iole.cs.brandeis.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1052061861 23839 62.216.29.197 (4 May 2003 15:24:21 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0305040922020.32427-100000@iole.cs.brandeis.edu>,
Mikhail Kruk  <meshko@cs.brandeis.edu> wrote:
>CLONE_FILES is an argument to clone(), I'm using pthreads and I don't 
>know if LinuxThreads implementation of pthreads gives me control of 
>how clone is called. Anyway, if I understand what CLONE_FILES does, 
>it should be given to clone, because threads do have to be able to share file 
>descriptors, probably. But not the locks!

Are you sure. I think threads /of a process/ have to share the
locks, under Linux that would translate to a thread-group.

Mike.

