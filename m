Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289882AbSAOPEY>; Tue, 15 Jan 2002 10:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289937AbSAOPET>; Tue, 15 Jan 2002 10:04:19 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:45061 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S289882AbSAOPDw>; Tue, 15 Jan 2002 10:03:52 -0500
From: Norbert Preining <preining@logic.at>
Date: Tue, 15 Jan 2002 16:03:15 +0100
To: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, andre@linuxdiskcert.org
Subject: Re: [BUG] 2.4.18.3, ide-patch, read_dev_sector hangs in read_cache_page
Message-ID: <20020115160315.A2515@alpha.logic.tuwien.ac.at>
In-Reply-To: <E16QU3F-0005g6-00@libra.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16QU3F-0005g6-00@libra.cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Die, 15 Jan 2002, Anton Altaparmakov wrote:
> Could you try this patchlet to fs/partitions/check.c::read_dev_sector() and look if there is any output by dmesg? It's
> a bit of a shot in the dark but will at least exclude this as the source for the peoblem...

No output to screen (and no dmesg of course ;-). I had some printk before
and after the read_cache_page call, the one before was shown, the one
after wasn't.


Herzliche Grüße

Norbert

-----------------------------------------------------------------------
Norbert Preining <preining@logic.at> 
University of Technology Vienna, Austria            gpg DSA: 0x09C5B094
-----------------------------------------------------------------------
AINSWORTH (n.)

The length of time it takes to get served in a camera shop. Hence,
also, how long we will have to wait for the abolition of income tax or
the Second Coming.

			--- Douglas Adams, The Meaning of Liff 
