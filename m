Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266991AbTAOUMn>; Wed, 15 Jan 2003 15:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266996AbTAOUMn>; Wed, 15 Jan 2003 15:12:43 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:25353 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S266991AbTAOUMm>; Wed, 15 Jan 2003 15:12:42 -0500
Date: Wed, 15 Jan 2003 20:21:34 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Marek Habersack <grendel@caudium.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XFS problems (hard lockup and oops on startup) with 2.5.5{6,7}
Message-ID: <20030115202134.A25143@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Marek Habersack <grendel@caudium.net>, linux-kernel@vger.kernel.org
References: <20030114175528.GA1213@thanes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030114175528.GA1213@thanes.org>; from grendel@caudium.net on Tue, Jan 14, 2003 at 06:55:28PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2003 at 06:55:28PM +0100, Marek Habersack wrote:
> Hello,
> 
>   The kernel 2.5.56 seems to have changed something that affected the XFS
> code as I'm getting hit by one (and possibly two) bugs related to it now.
> What happens is that the machine suddenly freezes (running Debian/Sid -
> XFree 4.2.1, glibc 2.3.1, gnome2 - nothing out of ordinary) so that SysRq
> keys don't have any effect (but Numlock still toggles the led on the
> keyboard), machine is inaccessible from the net and the only cure is hard
> reboot. Nothing gets logged on the freeze and on reboot when XFS attempts to
> check the first filesystem the kernel oopses with Oops code 0002, in the
> interrupt handler. Nothing gets logged, of course, so I can't provide the
> full backtrace right now - I'll try to get it logged through the serial console
> if it happens again with 2.5.58. I have copied some values by hand from the
> screen (until I lost patience... :)):
> 
> Unable to handle kernel paging request at virtual address 000500074
>  printing EIP

Hmm, that's really no much info.  And there weren't any XFS changes from
2.5.52 to 2.5.58..


