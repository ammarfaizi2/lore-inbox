Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265177AbUBAABI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 19:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265178AbUBAABI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 19:01:08 -0500
Received: from m029-035.nv.iinet.net.au ([203.217.29.35]:34440 "EHLO
	anu.rimspace.net") by vger.kernel.org with ESMTP id S265177AbUBAABG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 19:01:06 -0500
To: Jens Axboe <axboe@suse.de>
Cc: David Ford <david+challenge-response@blue-labs.org>,
       linux-kernel@vger.kernel.org, Mans Matulewicz <cybermans@xs4all.nl>
Subject: Re: ide-cdrom / atapi burning bug - 2.6.1
In-Reply-To: <20040131184923.GD11683@suse.de> (Jens Axboe's message of "Sat,
 31 Jan 2004 19:49:23 +0100")
References: <1075511134.5412.59.camel@localhost>
	<20040131093438.GS11683@suse.de> <401BF122.2090709@blue-labs.org>
	<20040131184923.GD11683@suse.de>
From: Daniel Pittman <daniel@rimspace.net>
Date: Sun, 01 Feb 2004 11:00:52 +1100
Message-ID: <87r7xfy8gb.fsf@enki.rimspace.net>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.5 (celeriac, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Jan 2004, Jens Axboe wrote:
> On Sat, Jan 31 2004, David Ford wrote:
>> I don't have an RW, but when my cdrom fixates, it stalls everything 
>> while it's fixating.  I have an nForce chipset.  (2.6.x)
> 
> Does "everything" mean everything on that ide channel? If so, then
> that's a hardware limitation.

My IBM A31p (Intel 845 chipset) had a similar problem with the CD
burner. Using the '-immed' flag resolved the issue for me.

        Daniel

-- 
To-morrow, and to-morrow, and to-morrow,
Creeps in this petty pace from day to day,
To the last syllable of recorded time;
        -- Macbeth; Act V, Scene VI
