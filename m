Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281155AbRKEOAl>; Mon, 5 Nov 2001 09:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281156AbRKEOAc>; Mon, 5 Nov 2001 09:00:32 -0500
Received: from mustard.heime.net ([194.234.65.222]:19601 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S281155AbRKEOAO>; Mon, 5 Nov 2001 09:00:14 -0500
Date: Mon, 5 Nov 2001 15:00:11 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Tux mailing list <tux-list@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Lots of questions about tux and kernel setup
In-Reply-To: <Pine.LNX.4.33.0111051519560.3082-100000@ahriman.bucharest.roedu.net>
Message-ID: <Pine.LNX.4.30.0111051429040.18879-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> to answer other "not asked" questions of yours ill point you to :
> http://www.specbench.org/osg/web99/results/res2000q4/web99-20001127-00075.html
>
> as that should help you very much :) (that /proc tweaking its pretty cool)

Thanks!

Just one thing...

I need redundancy, so I can't go with RAID 0. I thought I'd go with RAID
4, to avoid reading the parity info (and thereby wasting time), and still
have some quite good redundancy.

Q: Should I use hardware RAID or software RAID here? I can see they've
been using a rather large stripe (or chunk) size on the RAID (2MB). The
RAID controller I planned to use only supports up to 512kB stripes. As I
said, the files I'm reading are rather large - up to 10GB each, or at
least 1GB. I'm reading 4-7Mbps (500-900kB) per connection and each
connection reads only one file. Will a large stripe size help me here?

roy

---
Computers are like air conditioners.
They stop working when you open Windows.


