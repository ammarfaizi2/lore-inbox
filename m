Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271403AbRHOUOh>; Wed, 15 Aug 2001 16:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271402AbRHOUO1>; Wed, 15 Aug 2001 16:14:27 -0400
Received: from athena.intergrafix.net ([206.245.154.69]:12686 "HELO
	athena.intergrafix.net") by vger.kernel.org with SMTP
	id <S271403AbRHOUOR>; Wed, 15 Aug 2001 16:14:17 -0400
Date: Wed, 15 Aug 2001 16:14:30 -0400 (EDT)
From: Admin Mailing Lists <mlist@intergrafix.net>
To: Colonel <klink@clouddancer.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: WANTED: Re: VM lockup with 2.4.8 / 2.4.8pre8
In-Reply-To: <20010815193521.4DDE8783F5@mail.clouddancer.com>
Message-ID: <Pine.LNX.4.10.10108151612000.9584-100000@athena.intergrafix.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> >I also propose to half badness of processes with pid < 1000 - those
> >processes are usually also important, because they are called during
> >boot-time and they usually handle important system affairs.
> 
> 
> The belief that boot started processes remain under a pid < 1000 is
> flawed.  Simple example: the postfix mail server.
> 

agreed, but FWIW my postfix master daemon is pid 434

isn't this what Priority and Nice values are for, though?

-Tony
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.
Anthony J. Biacco                       Network Administrator/Engineer
thelittleprince@asteroid-b612.org       Intergrafix Internet Services

    "Dream as if you'll live forever, live as if you'll die today"
http://www.asteroid-b612.org                http://www.intergrafix.net
.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-.

