Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263516AbTEDGAw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 02:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263518AbTEDGAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 02:00:52 -0400
Received: from iole.cs.brandeis.edu ([129.64.3.240]:50829 "EHLO
	iole.cs.brandeis.edu") by vger.kernel.org with ESMTP
	id S263516AbTEDGAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 02:00:51 -0400
Date: Sun, 4 May 2003 02:13:25 -0400 (EDT)
From: Mikhail Kruk <meshko@cs.brandeis.edu>
To: <linux-kernel@vger.kernel.org>
Subject: fcntl file locking and pthreads
Message-ID: <Pine.LNX.4.33.0305040206270.20509-100000@iole.cs.brandeis.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
on 2.4 kernels fcntl-based file locking does not work with 
clone-based threads as expected (by me): two threads of the same process 
can acquire exclusive lock on a file at the same time.
flock()-based locks work as expected, i.e. only one thread can have an 
exclusive lock at a time.
What would it take to make fcntl work as flock?

Please cc me, I'm not subscribed.
Thanks

