Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267133AbSKMH5L>; Wed, 13 Nov 2002 02:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267134AbSKMH5L>; Wed, 13 Nov 2002 02:57:11 -0500
Received: from packet.digeo.com ([12.110.80.53]:45991 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267133AbSKMH4c>;
	Wed, 13 Nov 2002 02:56:32 -0500
Message-ID: <3DD20743.48DE596F@digeo.com>
Date: Wed, 13 Nov 2002 00:03:15 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Uwe Langenkamp <ul@uwe-langenkamp.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: System crashed (kernel bug report)
References: <JLECLKCMILLGAJOCDMKEOEDMCEAA.ul@uwe-langenkamp.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Nov 2002 08:03:16.0258 (UTC) FILETIME=[1F0B5820:01C28AEB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uwe Langenkamp wrote:
> 
> Hello,
> 
> after running 8 weeks without problems, our server had a system crash, I
> found the following bug message in /var/log/messages:
> 
> An additional information: Since 19th of October, the system is shut down by
> a SmartUPS over night (to save energy, from 11pm to 7am).
> 
> Nov 12 16:16:30 serv1 kernel: Assertion failure in
> journal_commit_transaction() at commit.c:535: "buffer_jdirty(bh)"
> ...
> Linux version 2.4.18-3smp (bhcompile@daffy.perf.redhat.com) (gcc version

Red Hat fixed this in 2.4.18-4.  See http://rhn.redhat.com/errata/RHBA-2002-085.html

Suggest you grab their latest kernel.
