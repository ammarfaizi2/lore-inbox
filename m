Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270809AbTHJX26 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 19:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270811AbTHJX26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 19:28:58 -0400
Received: from uni02du.unity.ncsu.edu ([152.1.13.102]:59266 "EHLO
	uni02du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S270809AbTHJX25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 19:28:57 -0400
From: jlnance@unity.ncsu.edu
Date: Sun, 10 Aug 2003 19:28:56 -0400
To: Eric Blade <eblade@blackmagik.dynup.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2/3 ESS1371 Audio
Message-ID: <20030810232856.GA13070@ncsu.edu>
References: <3F356881.9070206@blackmagik.dynup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F356881.9070206@blackmagik.dynup.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 09, 2003 at 05:32:49PM -0400, Eric Blade wrote:
> In 2.6.0-test1, the ESS1371 module stopped giving me sound output when 

FWIW, I compiled ESS1371 support into the kernel and it is found during
boot.  However, no sound comes from the card.  I did an strace of realplayer
and it is sucessfully opening /dev files for the device.  I do not know
when this started, as I have not been following 2.6 development closely.

I seem to remember someone having this problem in the past and it turned
out the be that the volume was turned down.  I would have thought that
realplayer would have turned it back up, so that probably is not the
problem.

Thanks,

Jim
