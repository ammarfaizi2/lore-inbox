Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262015AbSIYP7P>; Wed, 25 Sep 2002 11:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262016AbSIYP7P>; Wed, 25 Sep 2002 11:59:15 -0400
Received: from 62-190-216-141.pdu.pipex.net ([62.190.216.141]:52997 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S262015AbSIYP7O>; Wed, 25 Sep 2002 11:59:14 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209251611.g8PGBYZr003320@darkstar.example.net>
Subject: Re: hdparm -Y hangup
To: padraig.brady@corvil.com (Padraig Brady)
Date: Wed, 25 Sep 2002 17:11:34 +0100 (BST)
Cc: cogwepeter@cogweb.net, linux-kernel@vger.kernel.org, mlord@pobox.com
In-Reply-To: <3D91D0F2.5080806@corvil.com> from "Padraig Brady" at Sep 25, 2002 04:06:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> Clarification: is it the case that hdparm -Y (sleep) will cool the 
> >> drive off better than hdparm -y (suspend)?
> > 
> > 
> > In theory, -Y is capable of greater power (heat) savings than -y,
> > but in practice this will be model-specific and probably
> > will pale in comparism to the huge savings from -y alone.

Agreed.  It may well be less than one watt of power saving.

> True. Is there any chance you could mark -Y (DANGEROUS).
> Even if it is dangerous currently because of an IDE bug
> it still is dangerous.

I strongly disagree - we don't know that it fails on more than a few configurations at the moment.  If you mark everything as (DANGEROUS), then you might as well not mark any of it (DANGEROUS), and delete the whole package.

We need to establish what causes the -Y problem, and then ask Mark to put a note saying something like, 'Do not use on kernels < 2.4.X'

When I said the person to ask would be Mark, I *didn't* mean that I thought it *should* be marked (DANGEROUS), only that we should be investigating it!!!

> >> I read somewhere that -Y only works on unmounted drives. This appears 
> >> to be false. Comments?
> > 
> > It should work on the raw drive regardless.

There is no reason why it should fail on a mounted drive.

John.
