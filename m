Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317473AbSINT0H>; Sat, 14 Sep 2002 15:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317488AbSINT0H>; Sat, 14 Sep 2002 15:26:07 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:45300
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317473AbSINT0G>; Sat, 14 Sep 2002 15:26:06 -0400
Subject: Re: Possible bug and question about ide_notify_reboot in 2.4.19
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alex Davis <alex14641@yahoo.com>
Cc: miquels@cistron.nl, linux-kernel@vger.kernel.org
In-Reply-To: <20020914182804.28287.qmail@web40506.mail.yahoo.com>
References: <20020914182804.28287.qmail@web40506.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 14 Sep 2002 20:32:07 +0100
Message-Id: <1032031927.13636.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-09-14 at 19:28, Alex Davis wrote:
> >Putting the drive in stand-by mode has the side effect of flushing
> >the cache.
> Maxtor's tech support says this is NOT true.

Hint 1. Other people make disks too
Hint 2. The guys who did the code include a member of the standards
committee.


> Ok how about this: I'm current testing some patches against
> ide.c and friends. Why don't I just add ( and document ) a
> define called NO_STANDBY_ON_SHUTDOWN which would live in 
> ide.c. By default it would not be defined. Then I just wrap
> the standby code in an '#ifndef NO_STANDBY_ON_SHUTDOWN..#endif'
> block.

Unless Andre agrees the change is required in the new IDE they won't be
going in. 

