Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281183AbRKEPnN>; Mon, 5 Nov 2001 10:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281192AbRKEPnD>; Mon, 5 Nov 2001 10:43:03 -0500
Received: from mustard.heime.net ([194.234.65.222]:45201 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S281183AbRKEPmx>; Mon, 5 Nov 2001 10:42:53 -0500
Date: Mon, 5 Nov 2001 16:42:50 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Tux mailing list <tux-list@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Lots of questions about tux and kernel setup
In-Reply-To: <Pine.LNX.4.33.0111050849090.2102-100000@blap.linuxdev.us.dell.com>
Message-ID: <Pine.LNX.4.30.0111051554410.19457-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you spec your boxes such that you have extra CPU cycles around after
> TUX is done, consider software raid. Software raid is faster than hardware
> raid in almost every circumstance I have seen, with the caveat that it
> uses slightly more CPU resources (RAID 5 has worst CPU performance because
> of parity calculations, RAID 1 is better)

The only writing to the drives, will be weekly batch jobs running at
night. I originally planned to disable all or at least most loggin, but I
changed my mind to allow for logging to an NFS volume on a separate
management segment. Thus, there's virtually no writing in the system while
it's running. Therefor - again - I'd like to run software RAID 4, as
this'll give me read access to what looks like a RAID 0 (the n-1 data
drives), and although writing will be a pain in the ass, reading will be
fast, and I have some sort of redundancy.

What would you think would be a good stripe size in these circumstances
(>=1GB files)

roy


---
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.


