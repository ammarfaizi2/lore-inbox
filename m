Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262809AbSJLFmx>; Sat, 12 Oct 2002 01:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262811AbSJLFmx>; Sat, 12 Oct 2002 01:42:53 -0400
Received: from bgp01116664bgs.westln01.mi.comcast.net ([68.42.104.18]:6948
	"HELO blackmagik.dynup.net") by vger.kernel.org with SMTP
	id <S262809AbSJLFmw>; Sat, 12 Oct 2002 01:42:52 -0400
Subject: Re: export of sys_call_table
From: Eric Blade <eblade@blackmagik.dynup.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20021004.140629.89147658.davem@redhat.com>
References: <20021003153943.E22418@openss7.org>
	<1033682560.28850.32.camel@irongate.swansea.linux.org.uk> 
	<20021004.140629.89147658.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8.99 
Date: 12 Oct 2002 01:43:35 -0400
Message-Id: <1034401415.1630.395.camel@cpq>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is simply no portable way to make changes to the system call
> table, so exporting it makes zero sense.

I think, upon reading this entire conversation so far, that the
functionality is just about useless (ie, any programs that have taken
advantage of sys_call_table have been patched to not necessarily do so)
.. but if it were necessary, there could quite probably relatively
easily be a "addto_syscall_table" function or some such.  hmm.
	



