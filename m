Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319410AbSHNVsh>; Wed, 14 Aug 2002 17:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319412AbSHNVsh>; Wed, 14 Aug 2002 17:48:37 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:48079 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S319410AbSHNVsg>;
	Wed, 14 Aug 2002 17:48:36 -0400
Date: Wed, 14 Aug 2002 14:52:29 -0700
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Problem : can't make pipe non-blocking on 2.5.X
Message-ID: <20020814215229.GA24373@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20020814181902.GA24047@bougret.hpl.hp.com> <87lm79ru51.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lm79ru51.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2002 at 06:46:18AM +0900, OGAWA Hirofumi wrote:
> 
> F_GETFL should be,
>     flags = fcntl(trigger_pipe[0], F_GETFL, 0);

	Oups. I'll fix that. Thanks !

> > ------------- Output 2.5.25 ----------------
> > GET FLAGS : 0 - 40045F18
> > SET FLAGS : -1 - 22
> > ------------- Output 2.4.20-pre2 -----------
> > GET FLAGS : 0 - 40043F18
> > SET FLAGS : 0 - 0
> > --------------------------------------------
> 
> Looks like effect of different implement of O_DIRECT(0x40000).
> Thanks.

	Work in progress, I guess. Thanks...

	Jean
