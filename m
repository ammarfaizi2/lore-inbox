Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbTEDViT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 17:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbTEDViT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 17:38:19 -0400
Received: from iole.cs.brandeis.edu ([129.64.3.240]:1678 "EHLO
	iole.cs.brandeis.edu") by vger.kernel.org with ESMTP
	id S261786AbTEDViS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 17:38:18 -0400
Date: Sun, 4 May 2003 17:50:49 -0400 (EDT)
From: Mikhail Kruk <meshko@cs.brandeis.edu>
To: David Schwartz <davids@webmaster.com>
cc: <linux-kernel@vger.kernel.org>
Subject: RE: fcntl file locking and pthreads
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKMEIFCLAA.davids@webmaster.com>
Message-ID: <Pine.LNX.4.33.0305041741390.1510-100000@iole.cs.brandeis.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Two reference platforms for
> > threads are Solaris and Windows. I don't know how Solaris handles this,
> > but on Windows file locks are per thread, not per process.
> 
> 	Surely your argument isn't that UNIX should do things a certain way because
> that's how Windows does it? We can talk about two things, how things are and
> how they should be. This discussion seemed to be about how things should be.

I mentioned Windows because it happens to have a very mature threading 
implementation and I don't see why Unix can't look at something from 
Windows as a reference.
Anyway, I understand your argument about thread vs processes resources. I 
also checked that it works the same way on Solaris (which of course is a 
better reference point for Linux), so I agree that fcntl behavior is ok. 
Thanks for your explanation!

