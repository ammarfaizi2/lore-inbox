Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280306AbRKEHsx>; Mon, 5 Nov 2001 02:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280314AbRKEHsn>; Mon, 5 Nov 2001 02:48:43 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:45707 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S280306AbRKEHsX>; Mon, 5 Nov 2001 02:48:23 -0500
Date: Mon, 5 Nov 2001 09:48:16 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ext2 directory index, updated
Message-ID: <20011105094816.E26218@niksula.cs.hut.fi>
In-Reply-To: <20011104022659Z16995-4784+750@humbolt.nl.linux.org> <m3hesatcgq.fsf@borg.borderworlds.dk> <20011105014225Z17055-18972+38@humbolt.nl.linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011105014225Z17055-18972+38@humbolt.nl.linux.org>; from phillips@bonn-fries.net on Mon, Nov 05, 2001 at 02:43:28AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2001 at 02:43:28AM +0100, you [Daniel Phillips] claimed:
>
> Which kernel are you using?  From 2.4.10 on ext2 has an accelerator in 
> ext2_find_entry - it caches the last lookup position.  I'm wondering how that 
> affects this case.

Is that the same optimization Ted T'so implemented for ext3 around 0.9.10? I
thought it hadn't been ported the ext2...

BTW, I assume the ext2 dir index patch is roughly equivalent to FreeBSD
dirhash and the the other patch resembles theFreeBSD dirperf patch?
Have you looked at them? [http://www.osnews.com/story.php?news_id=153]


-- v --

v@iki.fi
