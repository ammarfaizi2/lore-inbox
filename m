Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263852AbTKLAJz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 19:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263854AbTKLAJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 19:09:55 -0500
Received: from mail3-126.ewetel.de ([212.6.122.126]:44782 "EHLO
	mail3.ewetel.de") by vger.kernel.org with ESMTP id S263852AbTKLAJu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 19:09:50 -0500
Date: Wed, 12 Nov 2003 01:09:34 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Daniel Pittman <daniel@rimspace.net>
cc: Linus Torvalds <torvalds@osdl.org>, Jens Axboe <axboe@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <87k766cv06.fsf@enki.rimspace.net>
Message-ID: <Pine.LNX.4.44.0311120107550.1066-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Nov 2003, Daniel Pittman wrote:

> The symptoms were exactly the same as above - I could mount and use the
> thing correctly, but the raw device was not readable at all.
> 
> Maybe cdrom_read_capacity can also return zero for some broken
> situations?

I put a printk in cdrom_read_capacity also, and the thing is never
even called for the MO drive because we don't get that far in
cdrom_read_toc in my case.

-- 
Ciao,
Pascal

