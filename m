Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276417AbRI2Cfz>; Fri, 28 Sep 2001 22:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276418AbRI2Cfq>; Fri, 28 Sep 2001 22:35:46 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:49613 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S276417AbRI2Cfg>; Fri, 28 Sep 2001 22:35:36 -0400
Date: Fri, 28 Sep 2001 22:35:02 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
        linux-tape@vger.kernel.org
Subject: Re: idetape broke in 2.4.x-2.4.9-ac5 (write OK but not read) ide-scsi works in 2.4.4
Message-ID: <20010928223502.D13766@devserv.devel.redhat.com>
In-Reply-To: <200109042234.AAA28635@harpo.it.uu.se> <20010927234023.A16753@devserv.devel.redhat.com> <15284.16283.111942.13934@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15284.16283.111942.13934@harpo.it.uu.se>; from mikpe@csd.uu.se on Fri, Sep 28, 2001 at 11:15:07AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Mikael Pettersson <mikpe@csd.uu.se>
> Date: Fri, 28 Sep 2001 11:15:07 +0200
> Cc: linux-kernel@vger.kernel.org, linux-tape@vger.kernel.org

>  > By the way, why does everyone insist on using ide-tape?
>  > It seems to be broken beyond any repair by injection of
>  > lethal poison marked "OnStream Support" (not that it was brilliant
>  > before, but that was the last nail in the coffin). Just use ide-scsi
>  > and be done with it. I really do not enjoy reading ide-tape.c.
> 
> I agree that ide-tape.c looks like a buggy piece of cr*p, but apart
> from that, what would I gain from using scsi tape on top of ide-scsi?
> Would it magically work on broken Colorados?

Umm... I hope someone else would fix ide-scsi when it breaks :)

I fixed Colorado, but it's certainly not the last bug.
Frist, DMA must be off, and it is often on by default.
Second, Dell QA already filed a new tapemark related bug...

-- Pete
