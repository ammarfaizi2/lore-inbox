Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268966AbRG0UkQ>; Fri, 27 Jul 2001 16:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268962AbRG0Uj7>; Fri, 27 Jul 2001 16:39:59 -0400
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:37636 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S268967AbRG0Ujr>; Fri, 27 Jul 2001 16:39:47 -0400
Date: Fri, 27 Jul 2001 14:39:52 -0600
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Strange remount behaviour with ext3-2.4-0.9.4
Message-ID: <20010727143952.A14248@mail.harddata.com>
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <20010727103221.F18669@dev.sportingbet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010727103221.F18669@dev.sportingbet.com>; from sean@dev.sportingbet.com on Fri, Jul 27, 2001 at 10:32:21AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, Jul 27, 2001 at 10:32:21AM +0100, Sean Hunter wrote:
> Following the announcement on lkml, I have started using ext3 on one of my
> servers.  Since the server in question is a farily security-sensitive box, my
> /usr partition is mounted read only except when I remount rw to install
> packages.

Regardless of possible weirdness in a "smart" behaviour of 'mount' what
one exactly buys running a journaling file system on a _read only_
partition?  fsck times will be the same (unless you crashed when
installing new software :-).

  Michal
