Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130055AbRBZA2P>; Sun, 25 Feb 2001 19:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130056AbRBZA2F>; Sun, 25 Feb 2001 19:28:05 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:15630 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130055AbRBZA15>;
	Sun, 25 Feb 2001 19:27:57 -0500
Date: Mon, 26 Feb 2001 01:27:30 +0100
From: Jens Axboe <axboe@suse.de>
To: Jonathan Oppenheim <jono@Phys.UAlberta.CA>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 242-ac3 loop bug
Message-ID: <20010226012730.W7830@suse.de>
In-Reply-To: <Pine.LNX.4.10.10102251701520.2320-100000@dirac.phys.ualberta.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10102251701520.2320-100000@dirac.phys.ualberta.ca>; from jono@Phys.UAlberta.CA on Sun, Feb 25, 2001 at 05:15:52PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25 2001, Jonathan Oppenheim wrote:
> i have also been having trouble with many cyphers including
> blowfish (although twofish and idea worked).  the error seems to be the
> same in all 2.4.x kernels (i have all the relevant options compiled
> as modules eg. loopback and ciphers))
> 
> i follow the encryptionhowto, but when i do a 
> losetup -e blah blah blah
> i get a segmentation fault (no core, no other error
> messages as far as i can see)
> 
> then, i can't rmmod the loop module and other modules because
> they are busy.
> 
> so i can't unmount the disk.
> 
> i haven't yet tried things with 2.4.2-ac3, but the problem
> seems to be with particular cyphers not with loopback.

So report the problem to the crypto folks people? I've seen several
of these now, but not one includes ksymoops info etc.

-- 
Jens Axboe

