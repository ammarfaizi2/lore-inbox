Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263075AbTC1RiN>; Fri, 28 Mar 2003 12:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263076AbTC1RiN>; Fri, 28 Mar 2003 12:38:13 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:51205 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S263075AbTC1RiM>;
	Fri, 28 Mar 2003 12:38:12 -0500
Date: Fri, 28 Mar 2003 18:49:26 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: torvalds@transmeta.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: lk-changelog.pl 0.89
Message-ID: <20030328174926.GA1596@mars.ravnborg.org>
Mail-Followup-To: Matthias Andree <matthias.andree@gmx.de>,
	torvalds@transmeta.com, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
References: <20030328105907.EAA9A484CB@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030328105907.EAA9A484CB@merlin.emma.line.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias.

When the script generates the changelog one person is often
listed twice or even more.

>From 2.5.65:
> Christoph Hellwig <hch@lst.de>:
>   o fix waitqueue leak in devfs_d_revalidate_wait
> 
> Christoph Hellwig <hch@sgi.com>:
>   o [XFS] remove fs/xfs/xfs_dqblk.h

Would it be possible to avoid this even with two so distinct adresses?
I see that regex will help here, but maybe not in all cases.

This is with the new script:
>Alan Cox <alan@hraefn.swansea.linux.org.uk>:
>  o Remove NO_VERSION from S390x exec32
>
>Alan Cox <alan@lxorguk.ukuu.org.uk>:
>  o Make ide use proper removal-safe list handling (removes endless looping
>    / hang)

It is not OK to say that all 'alan@*' is actually Alan Cox.

I'm not familiar enough with Perl to try myself :-(


	Sam
