Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131675AbRAFNFb>; Sat, 6 Jan 2001 08:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130429AbRAFNFV>; Sat, 6 Jan 2001 08:05:21 -0500
Received: from p3EE3CAC4.dip.t-dialin.net ([62.227.202.196]:16900 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S131090AbRAFNFP>; Sat, 6 Jan 2001 08:05:15 -0500
Date: Sat, 6 Jan 2001 12:26:39 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: reiserfs-list@namesys.com
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: ext3fs 0.0.5d and reiserfs 3.5.2x mutually exclusive
Message-ID: <20010106122639.A1334@emma1.emma.line.org>
Mail-Followup-To: reiserfs-list@namesys.com,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200101041815.f04IFkn31259@webber.adilger.net> <69180000.978632467@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <69180000.978632467@tiny>; from mason@suse.com on Thu, Jan 04, 2001 at 13:21:07 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Jan 2001, Chris Mason wrote:

> I keep saying I'm going to do this, and keep dropping it.  Your changes for
> reiserfs_journal_release and reiserfs_buffer_journaled are going into my
> tree right now.
> 
> Are there any others?

Yes, in buffer.c at least. I will publish a list later today or
tomorrow, and look if Andrea's VM-global has anything to do with that
since if buffer.c changes and fss change that as well, we have three
patches to merge. :-/

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
