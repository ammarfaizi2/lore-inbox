Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266055AbTFWOTp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 10:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266056AbTFWOTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 10:19:45 -0400
Received: from mail010.syd.optusnet.com.au ([210.49.20.138]:27576 "EHLO
	mail010.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266055AbTFWOTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 10:19:43 -0400
Date: Tue, 24 Jun 2003 00:32:26 +1000
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-ac2
Message-ID: <20030623143226.GA15804@cancer>
References: <200306221701.h5MH1Wh15378@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306221701.h5MH1Wh15378@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.4i
From: Stewart Smith <stewart@linux.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 22, 2003 at 01:01:32PM -0400, Alan Cox wrote:
> Not yet resynchronized with Marcelo 2.4.22-pre1. XFS should work still but
> may need some updates for the O_DIRECT changes. The exploding audio driver
> problem should be fixed.
> 
> Linux 2.4.21-ac2
<snip>
> o	O_DIRECT race fixes				(Stephen Tweedie)
> 	| Tweaked a little to merge with XFS. XFS folks should double
> 	| check these.

Been running for a bit over an hour under (relatively) heavy load.
Dual PII 350,
2.4.21-ac2 compile,
tridge's fstest.c (samba.org/ftp/unpacked/junkcode/fstest.c) in various
configurations
cp -rl linux-2.5.72 linux-2.5.73
patch to 2.5.73

all on XFS partition (/ is ext3, /home (where i work) is xfs)
all going okay (i.e. no weirdness) and tests passed.

so if anything is wrong, it's at least a (bit) obscure :)

--
Stewart Smith
Vice President, Linux Australia
http://www.linux.org.au (personal: http://www.flamingspork.com)
