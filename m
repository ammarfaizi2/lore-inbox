Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284584AbRLZRVP>; Wed, 26 Dec 2001 12:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284599AbRLZRU4>; Wed, 26 Dec 2001 12:20:56 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:46513 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S284584AbRLZRUp>;
	Wed, 26 Dec 2001 12:20:45 -0500
Date: Wed, 26 Dec 2001 12:20:44 -0500
From: Legacy Fishtank <garzik@havoc.gtf.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre2 forces ramfs on
Message-ID: <20011226122044.A7125@havoc.gtf.org>
In-Reply-To: <a0bj07$18l$1@penguin.transmeta.com> <E16JFbk-00028a-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16JFbk-00028a-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Dec 26, 2001 at 03:04:40PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2001 at 03:04:40PM +0000, Alan Cox wrote:
> > Because it's small, and if it wasn't there, we'd have to have the small
> > "rootfs" anyway (which basically duplicated ramfs functionality).
> 
> Can ramfs=N longer term actually come back to be "use __init for the RAM
> fs functions". That would seem to address any space issues even the most 
> embedded fanatic has. 

Nifty idea... We could use __rootfs or similar in the module.

	Jeff


