Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbUJ3S0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbUJ3S0o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 14:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbUJ3SY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 14:24:56 -0400
Received: from [195.56.65.174] ([195.56.65.174]:64517 "EHLO h.kenyer.hu")
	by vger.kernel.org with ESMTP id S261307AbUJ3SYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 14:24:17 -0400
Subject: Re: 2.6.10-rc1 crashes on recursive directory walk [2.6.9 was OK]
From: dap <dap@kenyer.hu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20041030172450.GA1834@middle.of.nowhere>
References: <1099156115.14842.322.camel@localhost>
	 <20041030172450.GA1834@middle.of.nowhere>
Content-Type: text/plain
Message-Id: <1099160651.14837.347.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 30 Oct 2004 20:24:11 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 2004-10-30 at 19:24, Jurriaan wrote:
> From: dap <dap@kenyer.hu>
> Date: Sat, Oct 30, 2004 at 07:08:36PM +0200
> > 
> >  I've used xfs and ext3 on a large ftp server with lots of files, and
> > when I do a 'find / -ls' with the kernel 2.6.10-rc1, the server crashes
> > with no Oops or other message. only the reset button give a response.. I
> > can reproduce it any time with find, but the point of crash is random,
> > it can crash on xfs and ext3 partitions too..  2.6.9 works fine in this
> > environment..
> > 
> What are the tailing lines of 'strace find / -ls' ? 

 the only problem is that it's a productive server with large, software
raid5 arrays and lockups can trigger resync`s that leads to a
significant performance degradation for days and the users really hates
this, so I'll try to reproduce it with another box on this weekend. if I
can't, I'll do it on the productive server and send the results..


-- 
dap


