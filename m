Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281087AbRKLWbx>; Mon, 12 Nov 2001 17:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281075AbRKLWbd>; Mon, 12 Nov 2001 17:31:33 -0500
Received: from stine.vestdata.no ([195.204.68.10]:37305 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S281079AbRKLWb0>; Mon, 12 Nov 2001 17:31:26 -0500
Date: Mon, 12 Nov 2001 23:30:56 +0100
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Lionel Bouton <Lionel.Bouton@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: File System Performance
Message-ID: <20011112233056.B9043@vestdata.no>
In-Reply-To: <3BF04926.2080009@free.fr> <Pine.LNX.4.33.0111121411410.7555-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0111121411410.7555-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Nov 12, 2001 at 02:14:59PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2001 at 02:14:59PM -0800, Linus Torvalds wrote:
> > Seems not the case with gnu tar : write isn't even called once on the fd
> > returned by open("/dev/null",...). In fact a "grep write" on the strace
> > output is empty in the "tar cf /dev/null" case. Every file in the tar-ed
> > tree is stat-ed but no-one is read-ed.
> 
> And what's the _point_ of the optimization? I've never heard of a "tar
> benchmark"..

Sure - it's called "amanda" :-)


I believe amanda run the backup once to /dev/null first to estimate the
size of the dataset, so it can make better use of the available tapes.


-- 
Ragnar Kjørstad
Big Storage
