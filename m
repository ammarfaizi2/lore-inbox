Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129322AbRBUVJf>; Wed, 21 Feb 2001 16:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129379AbRBUVJ0>; Wed, 21 Feb 2001 16:09:26 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:44297 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S129322AbRBUVJH>; Wed, 21 Feb 2001 16:09:07 -0500
Date: Wed, 21 Feb 2001 22:08:35 +0100
From: Martin Mares <mj@suse.cz>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Daniel Phillips <phillips@innominate.de>, ext2-devel@lists.sourceforge.net,
        hch@ns.caldera.de, Andreas Dilger <adilger@turbolinux.com>,
        tytso@valinux.com, Linux-kernel@vger.kernel.org
Subject: Re: [rfc] Near-constant time directory index for Ext2
Message-ID: <20010221220835.A8781@atrey.karlin.mff.cuni.cz>
In-Reply-To: <01022020011905.18944@gimli> <XFMail.20010221092103.davidel@xmailserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <XFMail.20010221092103.davidel@xmailserver.org>; from davidel@xmailserver.org on Wed, Feb 21, 2001 at 09:21:03AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Have You tried to use skiplists ?
> In 93 I've coded a skiplist based directory access for Minix and it gave very
> interesting performances.
> Skiplists have a link-list like performance when linear scanned, and overall
> good performance in insertion/seek/delete.

Skip list search/insert/delete is O(log N) in average as skip lists are just a
dynamic version of interval bisection. Good hashing is O(1).

				Have a nice fortnight
-- 
Martin `MJ' Mares <mj@ucw.cz> <mj@suse.cz> http://atrey.karlin.mff.cuni.cz/~mj/
Entropy isn't what it used to be.
