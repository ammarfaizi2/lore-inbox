Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315406AbSHNSuN>; Wed, 14 Aug 2002 14:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319267AbSHNSuN>; Wed, 14 Aug 2002 14:50:13 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:15328 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S315406AbSHNSuM>;
	Wed, 14 Aug 2002 14:50:12 -0400
Date: Wed, 14 Aug 2002 11:54:05 -0700
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Problem : can't make pipe non-blocking on 2.5.X
Message-ID: <20020814185405.GD24047@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20020814181902.GA24047@bougret.hpl.hp.com> <Pine.LNX.3.95.1020814143548.137A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1020814143548.137A-100000@chaos.analogic.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2002 at 02:43:01PM -0400, Richard B. Johnson wrote:
> On Wed, 14 Aug 2002, Jean Tourrilhes wrote:
> 
> > 
> >   pipe(trigger_pipe);
> > 
>     if((flags = fcntl(trigger_pipe[0], F_GETFL)) != -1);
>        flags &= ~O_NDELAY;
>     fcntl(trigger_pipe[0], F_SETFL, flags);

	Same error. Please try again.

	Jean
