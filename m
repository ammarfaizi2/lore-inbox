Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUB1XjG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 18:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbUB1XjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 18:39:06 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:30372 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261931AbUB1XjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 18:39:04 -0500
Date: Sun, 29 Feb 2004 00:39:03 +0100
From: bert hubert <ahu@ds9a.nl>
To: Pavel Machek <pavel@suse.cz>
Cc: discuss@x86-64.org, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: scp running too slow
Message-ID: <20040228233903.GA14238@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Pavel Machek <pavel@suse.cz>, discuss@x86-64.org,
	kernel list <linux-kernel@vger.kernel.org>
References: <20040228222942.GA736@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040228222942.GA736@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 28, 2004 at 11:29:42PM +0100, Pavel Machek wrote:
> Hi!
> 
> I'm copying huge file from x86-64 machine to i386.
> 
> x86-64 is running 2.6.3-bk, today from Linus' cvs. tg3 driver. It
> shows pretty high CPU load (like 98% CPU), and is not even able to
> reach 1MB/sec. When x86-64 machine was running 2.4, I was able to get
> >4MB/sec...

Could you provide slightly more data? like the output of vmstat 1 or a
tcpdump. Also, is a transfer going the other way faster, does -C none help
etc.


-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
