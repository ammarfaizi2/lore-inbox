Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbUEVRAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbUEVRAA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 13:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUEVQ6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 12:58:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:1701 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261682AbUEVQ6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 12:58:37 -0400
Date: Thu, 20 May 2004 21:27:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Elladan <elladan@eskimo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Consistent deadlock+crash in 2.6.5 when writing large file to CFSd (over NFS)
Message-ID: <20040520192751.GD5215@openzaurus.ucw.cz>
References: <20040519075336.GA2020@eskimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040519075336.GA2020@eskimo.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'm getting consistent crashes in 2.6.5 when I write a large file to cfs
> (crypto file system).  This is a user daemon that implements an NFS
> export of encrypted files on disk.
> 
> Basically, what appears to happen is that it's deadlocking something in
> the IO system.  I can't really tell what, because the entire system
> seizes up soon afterward.

...

> Any ideas?

Are you doing r/w mount from process that is on local machine?
That would be broken by design.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

