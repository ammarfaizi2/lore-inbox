Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262583AbRE3C1K>; Tue, 29 May 2001 22:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262579AbRE3C0u>; Tue, 29 May 2001 22:26:50 -0400
Received: from femail15.sdc1.sfba.home.com ([24.0.95.142]:47551 "EHLO
	femail15.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S262580AbRE3C0s>; Tue, 29 May 2001 22:26:48 -0400
Date: Tue, 29 May 2001 22:26:39 -0400
From: Tom Vier <tmv5@home.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-ac3: qlogic corruption on alpha
Message-ID: <20010529222639.B2090@zero>
In-Reply-To: <20010529210958.A821@zero> <3B144A39.8471B53E@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B144A39.8471B53E@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Tue, May 29, 2001 at 09:17:45PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2001 at 09:17:45PM -0400, Jeff Garzik wrote:
> Tom Vier wrote:
> > i narrowed down some corruption i was having. it only happens on drives
> > attached to my qlogic isp card. 2.2 has no problem, and in 2.4.5-ac3 my
> > sym53c875 works fine. this machine is an alpha miata. it only happens when
> > writing out a lot to disk. eg, untarring a kernel tarball, restoring a
> > backup. anyone else see this?
> 
> Is this reproducible?

yes. by restoring a backup from tape. i tried cat /dev/zero > /dev/sdb1,
but that wasn't enough to trigger any corruption (i correctly wrote all
zeros). actually, now that i think about it, a good chunk of /dev/sdb2 was
cached when i read it back, so that wasn't a very good test. i definetly get
corruption under 2.4.5-ac4.

<snip>

> Other questions - is your machine SMP?  How much RAM?

UP, half gig.

-- 
Tom Vier <tmv5@home.com>
DSA Key id 0x27371A2C
