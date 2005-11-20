Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbVKUAjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbVKUAjP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 19:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbVKUAjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 19:39:15 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:60033 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750778AbVKUAjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 19:39:14 -0500
Date: Sun, 20 Nov 2005 21:30:55 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Bradley Chapman <kakadu@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Laptop mode causing writes to wrong sectors?
Message-ID: <20051120213054.GA2556@spitz.ucw.cz>
References: <e294b46e0511170522v5762d48jcaff8413e33b2ebe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e294b46e0511170522v5762d48jcaff8413e33b2ebe@mail.gmail.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I too have been experiencing some problems with laptop-mode that may
> be similar to what was recently reported here.
> 
> I have a Centrino machine (Sager NP3760, aka Clevo M375E) with a 60GB
> Hitachi TravelStar hard disk running in UDMA5 and 512MB RAM, and on
> occassions I've had random files on my /usr partition overwritten and
> both my /usr and /var filesystems quite thoroughly trashed - with
> these events usually occuring right after I'd been on battery power
> and my hard disk had been spinning up and down regularly.
> 
> All my filesystems are ext3 with journaling active, and none of them
> have been messed with (i.e. resized).

Can you try ext2? Relying on journal when you are experiencing corruption 
is bad idea, anyway.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

