Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289255AbSBNAki>; Wed, 13 Feb 2002 19:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289243AbSBNAk3>; Wed, 13 Feb 2002 19:40:29 -0500
Received: from dsl-213-023-039-092.arcor-ip.net ([213.23.39.92]:9358 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289255AbSBNAkW>;
	Wed, 13 Feb 2002 19:40:22 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rob Landley <landley@trommello.org>
Subject: Re: [patch] sys_sync livelock fix
Date: Thu, 14 Feb 2002 01:44:45 +0100
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1020212220340.8017A-100000@gatekeeper.tmr.com> <E16b14Z-0001oR-00@starship.berlin> <20020213233051.GSSQ97.femail9.sdc1.sfba.home.com@there>
In-Reply-To: <20020213233051.GSSQ97.femail9.sdc1.sfba.home.com@there>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16bA0z-0002QV-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 14, 2002 12:31 am, Rob Landley wrote:
> On Wednesday 13 February 2002 10:11 am, Daniel Phillips wrote:
> 
> > On this topic, it would make a lot of sense from the user's point of view
> > to have a way of syncing a single volume, how would we express that?
> 
> If you're talking about sync(1), I'd make it work like df.  Typing df with no 
> arguments lists all volumes, df with a path looks at just that path.  (And 
> "df ." works fine too.)

Yes, that's the right interface from the user's point of view.

> If you're asking about sync(2) and how it should talk to the kernel, I'm not 
> going to express an opinion...

Patches speak louder than opinions.  First we need a vfs super->sync method,
coming soon.

-- 
Daniel
