Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750737AbWFDQ3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWFDQ3t (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 12:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWFDQ3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 12:29:49 -0400
Received: from ptb-relay03.plus.net ([212.159.14.214]:50918 "EHLO
	ptb-relay03.plus.net") by vger.kernel.org with ESMTP
	id S1750737AbWFDQ3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 12:29:48 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: "davor emard" <davoremard@gmail.com>
Subject: Re: SMP HT + USB2.0 crash
Date: Sun, 4 Jun 2006 17:30:04 +0100
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <beee72200606040322w2960e5f9j1716addc39949ccb@mail.gmail.com> <200606041706.28073.s0348365@sms.ed.ac.uk> <beee72200606040923h670cf61dn22a61518ef94013f@mail.gmail.com>
In-Reply-To: <beee72200606040923h670cf61dn22a61518ef94013f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606041730.04129.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 June 2006 17:23, davor emard wrote:
[snip]
> > Secondly, I highly recommend running memtest86 on your system for at
> > least a couple of passes. You can download an ISO from the homepage and
> > boot it from a CD. If this fails, you have faulty memory.
>
> hmm I don't know why I didn't use memtest86. but I usually test memory on
> new machine linux, by continuously gzip-ing and ungzip-ing
> 4GB file for 2 days and verify if the beginning
> and the end file  are the same memory, CPU and a bit of
> hardware handling them together should be good...

The reason I'm suggesting memtest86, is that it can detect very subtle errors 
(gzip will not do this). The crash you're experiencing is in core kernel 
code, and it is very unlikely to be a real bug.

This is why Con and myself have suggested to reproduce without the binary 
junk, and why bad memory could be a very probable cause.

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
