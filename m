Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289138AbSBMXbK>; Wed, 13 Feb 2002 18:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289166AbSBMXbD>; Wed, 13 Feb 2002 18:31:03 -0500
Received: from femail9.sdc1.sfba.home.com ([24.0.95.89]:63698 "EHLO
	femail9.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S289139AbSBMXaw>; Wed, 13 Feb 2002 18:30:52 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: [patch] sys_sync livelock fix
Date: Wed, 13 Feb 2002 18:31:44 -0500
X-Mailer: KMail [version 1.3.1]
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1020212220340.8017A-100000@gatekeeper.tmr.com> <3C69E1AE.B225A392@mandrakesoft.com> <E16b14Z-0001oR-00@starship.berlin>
In-Reply-To: <E16b14Z-0001oR-00@starship.berlin>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020213233051.GSSQ97.femail9.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 February 2002 10:11 am, Daniel Phillips wrote:

> On this topic, it would make a lot of sense from the user's point of view
> to have a way of syncing a single volume, how would we express that?

If you're talking about sync(1), I'd make it work like df.  Typing df with no 
arguments lists all volumes, df with a path looks at just that path.  (And 
"df ." works fine too.)

If you're asking about sync(2) and how it should talk to the kernel, I'm not 
going to express an opinion...

Rob
