Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265144AbUFATFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbUFATFY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 15:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265146AbUFATFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 15:05:24 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:60679 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S265144AbUFATFL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 15:05:11 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <robin.rosenberg.lists@dewire.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: why swap at all? (what the user feels)
Date: Tue, 1 Jun 2004 12:04:56 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKAEHCMFAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <200406012101.40302.robin.rosenberg.lists@dewire.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2120
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Tue, 01 Jun 2004 11:42:56 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Tue, 01 Jun 2004 11:43:01 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Tuesday 01 June 2004 20.01, David Schwartz wrote:
> > >  From what I've read previously in this thread, it seems to
> > > me that the
> > > only major problem with swapping that not all users want file system
> > > cache to swap out actual applications (thus making that somewhat aged
> > > mozilla window abit laggy).
> > >
> > > Maybe we could just have a "Allow file system cache to swap out
> > > applications checkbox somewhere"?
> > >
> > > Or, Am I missing something?

> > 	In practice, that would make no difference at all. Once
> > physical memory is
> > full (and it pretty much will always be so), every memory
> request (whether

> No.

	Huh?

> Many people have machines with plenty of RAM (512MB or more is
> pretty much
> standard on new machines), much of which is only used to cache files. The
> file cache is the reason the memory is full.

	Of course. That's why I said, "once physical memory is full (and it pretty
much will always be so)". Physical memory is always full, so every memory
request requires that a page be evicted.

	DS


