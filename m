Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262069AbSIYThw>; Wed, 25 Sep 2002 15:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262074AbSIYThw>; Wed, 25 Sep 2002 15:37:52 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6404 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262069AbSIYThv>; Wed, 25 Sep 2002 15:37:51 -0400
Date: Wed, 25 Sep 2002 12:45:37 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [ANNOUNCE] [patch] kksymoops, in-kernel symbolic oopser, 2.5.38-B0
In-Reply-To: <Pine.LNX.4.44.0209251415500.28659-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.33.0209251245070.2836-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Sep 2002, Kai Germaschewski wrote:
> 
> So this patch converts the output to the more familiar
> 
> 	sys_gettimeofday+0x84/0x108 [module-name]
> 
> format, where module-name is "" for the kernel. 

I want those [] gone too, I see no reason for them except to make the 
output ugly.

		Linus

