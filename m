Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264021AbSJOSxt>; Tue, 15 Oct 2002 14:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264632AbSJOSxt>; Tue, 15 Oct 2002 14:53:49 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:13791 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S264021AbSJOSxp>; Tue, 15 Oct 2002 14:53:45 -0400
Subject: Re: Problem with jfs and dbench 80 (ext3, reiserfs, xfs are OK)
From: Steven Cole <elenstev@mesatop.com>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200210151317.01493.shaggy@austin.ibm.com>
References: <1034695794.13083.27.camel@spc9.esa.lanl.gov> 
	<200210151317.01493.shaggy@austin.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 15 Oct 2002 12:54:38 -0600
Message-Id: <1034708078.13083.41.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-15 at 12:17, Dave Kleikamp wrote:
> On Tuesday 15 October 2002 10:29, Steven Cole wrote:
> > I have run into problems running dbench with 80 clients
> > on a jfs partition.
> 
> Steven,
> I haven't run dbench with that many clients myself (or if I had, it's 
> been a while).  I'm currently working on fixing some scalability issues 
> in JFS.  In doing so, I'll try to reproduce your problem and make sure 
> it gets fixed.
> 
> Thanks,
> Shaggy

When I rebooted the test box to run 2.5.42-bk2, I said Y to running
fsck, and when fsck.jfs was run on that jfs partition, I saw one message
which indicated that a problem had been found.  The message scrolled
away before I could save it.  I immediately ran dbench with 64 clients
and then dbench with 80 clients on the jfs partition, this time
successfully.  I'm now repeating the full ramp up dbench run, up to 128
clients. If nothing breaks, I'll shake it a little harder (like doing
several kernel compiles while dbench is trying to run).

Thanks,
Steven

