Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267490AbRGUAGn>; Fri, 20 Jul 2001 20:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267492AbRGUAGd>; Fri, 20 Jul 2001 20:06:33 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:42889 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267490AbRGUAGT>; Fri, 20 Jul 2001 20:06:19 -0400
Date: Fri, 20 Jul 2001 18:03:08 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Paul Jakma <paulj@alphyra.ie>
Cc: Chris Wedgwood <cw@f00f.org>, Andreas Dilger <adilger@turbolinux.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 64 bit scsi read/write
Message-ID: <20010720180308.A18669@redhat.com>
In-Reply-To: <20010715024859.A6722@weta.f00f.org> <Pine.LNX.4.33.0107141641030.1063-100000@rossi.itg.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0107141641030.1063-100000@rossi.itg.ie>; from paulj@alphyra.ie on Sat, Jul 14, 2001 at 04:42:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

On Sat, Jul 14, 2001 at 04:42:04PM +0100, Paul Jakma wrote:
> 
> > *why* would you want to to do this?
> 
> :)
> 
> to test performance advantage of journal on RAM before going to spend
> money on NVRAM...

Journaling to ramdisk has been tried, yes.  The result was faster than
ext2 doing the same jobs.  Of course, the support for journal to
external devices is still only really at prototype stage.

Cheers,
 Stephen
