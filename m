Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131429AbRC3NvN>; Fri, 30 Mar 2001 08:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131446AbRC3NvD>; Fri, 30 Mar 2001 08:51:03 -0500
Received: from mail1.one.net ([206.112.192.107]:4192 "EHLO mail1.one.net")
	by vger.kernel.org with ESMTP id <S131429AbRC3Nuq>;
	Fri, 30 Mar 2001 08:50:46 -0500
From: Dale E Martin <dmartin@cliftonlabs.com>
Date: Fri, 30 Mar 2001 08:49:47 -0500
To: khromy <khromy@khromy.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EXT2-fs error
Message-ID: <20010330084947.A16523@gerbil>
In-Reply-To: <20010329220630.A32834@khromy.lnuxlab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010329220630.A32834@khromy.lnuxlab.net>; from khromy@khromy.lnuxlab.net on Thu, Mar 29, 2001 at 10:06:30PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linux vingeren.girl 2.4.3-pre7 #5 Mon Mar 26 23:33:59 EST 2001 i686 unknown
> 
> EXT2-fs error (device ide2(33,3)): ext2_free_blocks: bit already cleared for block 1048576
> EXT2-fs error (device ide2(33,3)): ext2_free_blocks: bit already cleared for block 1048576
> 
> ^
> I got the following while rm -rf'ing my mozilla cvs checkout.  Deadly or not deadly?

Are you running with a Buslogic SCSI card?  2.4.x (x < 3 - pre something)
has a problem with them.  I was seeing exactly these sorts of errors before
I went to 2.4.3 pre-8.

Later,
	Dale
-- 
Dale E. Martin, Clifton Labs, Inc.
Senior Computer Engineer
dmartin@cliftonlabs.com
http://www.cliftonlabs.com
pgp key available
