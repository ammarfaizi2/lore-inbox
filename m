Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267376AbUJBJfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267376AbUJBJfw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 05:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266572AbUJBJfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 05:35:51 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:4736 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S267376AbUJBJfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 05:35:40 -0400
Date: Fri, 1 Oct 2004 15:40:05 +0200
From: Pavel Machek <pavel@suse.cz>
To: Mitch DSouza <Mitch@0Bits.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3 software suspend (pmdisk) stopped working
Message-ID: <20041001134004.GD1100@openzaurus.ucw.cz>
References: <415D311E.2050006@0Bits.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415D311E.2050006@0Bits.COM>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I thought i was going barmy. I've reverted back to -rc2 which
> pmdisk works flawlessly on my laptop.

Actually problem turned out to be in highmem. Unless you
are using highmem, -rc3 should work. You'll need to change config if
switching from pmdisk to swsusp...

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

