Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277629AbRKACGf>; Wed, 31 Oct 2001 21:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277585AbRKACGZ>; Wed, 31 Oct 2001 21:06:25 -0500
Received: from CompactServ-SUrNet.ll.surnet.ru ([195.54.9.58]:3824 "EHLO
	zzz.zzz") by vger.kernel.org with ESMTP id <S277612AbRKACGP>;
	Wed, 31 Oct 2001 21:06:15 -0500
Date: Thu, 1 Nov 2001 07:05:30 +0500
From: Denis Zaitsev <zzz@cd-club.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init/main.c/root_dev_names - another one #ifdef
Message-ID: <20011101070530.C22507@zzz.zzz.zzz>
In-Reply-To: <E15yj2E-0001o7-00@the-village.bc.nu> <Pine.LNX.4.33.0110301610460.1336-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110301610460.1336-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Oct 30, 2001 at 04:12:36PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 04:12:36PM -0800, Linus Torvalds wrote:
> I think that array really is broken. We should get the name association
> from the array that "register_blkdev()" maintains, I'm sure. That way

If this array will be thrown away, am I right that we will lose an
ability to do root=/dev/hda ?  As only "new names" will retain?  And
by the way, it seems that devfs maintains the neccessary information,
not the array you have mentioned...
