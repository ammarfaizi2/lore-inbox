Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbTDDX6h (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 18:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbTDDX6g (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 18:58:36 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.28]:41309 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S261474AbTDDX6c (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 18:58:32 -0500
Message-ID: <036201c2fb07$b41b8340$2e77c23e@pentium4>
From: "Jonathan Vardy" <jonathanv@explainerdc.com>
To: <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <73300040777B0F44B8CE29C87A0782E101FA98FB@exchange.explainerdc.com>
Subject: Re: RAID 5 performance problems
Date: Sat, 5 Apr 2003 02:10:02 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RE: RAID 5 performance problems> I've rebooted with the original Red Hat
kernel (2.4.20) and it
> recognizes the drives correctly now (UDMA100) but the performance is
> still poor

Good news; I've finally got the performance up to a good level. Bonnie++ now
gives 77MB/sec read and 25MB/sec write speeds.

The problem was being caused by a setting in the mainbaord BIOS; "PCI
latency timer" had a default value of 0, after changing this to 32 the drive
speed (hdparm) doubled and the raid finally performed as it should.

I'd like to thank everybody who responded for giving me advice on the
problem, I apreciate it greatly.

Yours sincerely, Jonathan Vardy

