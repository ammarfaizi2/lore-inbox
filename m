Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129712AbRC0AFM>; Mon, 26 Mar 2001 19:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129719AbRC0AFC>; Mon, 26 Mar 2001 19:05:02 -0500
Received: from d83b5259.dsl.flashcom.net ([216.59.82.89]:48004 "EHLO
	home.lameter.com") by vger.kernel.org with ESMTP id <S129712AbRC0AEy>;
	Mon, 26 Mar 2001 19:04:54 -0500
Date: Mon, 26 Mar 2001 15:21:29 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
To: Chris Mason <mason@suse.com>
cc: linux-kernel@vger.linux.org
Subject: Re: ReiserFS phenomenon with 2.4.2 ac24/ac12
In-Reply-To: <87200000.985628791@tiny>
Message-ID: <Pine.LNX.4.21.0103261520480.28218-100000@home.lameter.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Mar 2001, Chris Mason wrote:

> On Saturday, March 24, 2001 11:56:08 AM -0800 Christoph Lameter
> <christoph@lameter.com> wrote:
> 
> > I got a directory /a/yy that I tried to erase with rm -rf /a/yy.
> > 
> > rm hangs...
> > 
> > ls gives the following output:
> > 
> > ls: /a/yy/cache3A0F94EA0A00557.html: No such file or directory
> > ls: /a/yy/cache3A0F94EA0A00557.html: No such file or directory
> > ls: /a/yy/cache3A8CCC6A0490B05.gifcache393C2B6A2CD2DF1.crumb: No such file
> > or directory
> > ls: /a/yy/cache3A0F94EA0A00557.html: No such file or directory
> > ls: /a/yy/cache3A0F94EA0A00557.html: No such file or directory
> > ls: /a/yy/cache3A8CCC6A0490B05.gifcache393C2B6A2CD2DF1.crumb: No such file
> > or directory
> > 
> > and so on and so on....
> > 
> > I tried a reiserfscheck -x on the /a volume but the strangeness still
> > persists. What is going on here?
> There should be more messages on the console that will help identify the
> problem.  Please check through /var/log/messages and send along anything that
> looks odd.


Yes I see messages like this in the log:

Mar 26 06:47:50 k2-400 kernel: Out of Memory: Killed process 421 (mysqld).
Mar 26 06:48:02 k2-400 kernel: Out of Memory: Killed process 425 (mysqld).
Mar 26 06:48:04 k2-400 kernel: Out of Memory: Killed process 426 (mysqld).
Mar 26 06:48:04 k2-400 kernel: Out of Memory: Killed process 427 (mysqld).
Mar 26 06:48:04 k2-400 kernel: Out of Memory: Killed process 562 (apache).
Mar 26 06:48:04 k2-400 kernel: Out of Memory: Killed process 563 (apache).
Mar 26 06:48:04 k2-400 kernel: Out of Memory: Killed process 564 (apache).              


