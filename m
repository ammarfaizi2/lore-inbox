Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261801AbTCZRLP>; Wed, 26 Mar 2003 12:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261802AbTCZRLP>; Wed, 26 Mar 2003 12:11:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25094 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261801AbTCZRLO>; Wed, 26 Mar 2003 12:11:14 -0500
Date: Wed, 26 Mar 2003 09:21:22 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Matthias Andree <matthias.andree@gmx.de>
cc: linux-kernel@vger.kernel.org, <samel@mail.cz>,
       <ma@dt.e-technik.uni-dortmund.de>
Subject: Re: BK-kernel-tools/shortlog update
In-Reply-To: <20030326103036.064147C8DD@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.44.0303260917320.15530-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Mar 2003, Matthias Andree wrote:
> 
> you can either use bk receive to patch this mail, you can pull from
> bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no trailing slash)
> or you can apply the patch below.

Btw, one feature I'd like to see in shortlog is the ability to use 
regexps for email address matching, ie something like

	'torvalds@.*transmeta.com' => 'Linus Torvalds'
	... 
	'alan@.*swansea.linux.org.uk' => 'Alan Cox'
	...
	'bcrl@redhat.com' => 'Benjamin LaHaise',
	'bcrl@.*' => '?? Benjamin LaHaise',
	..

I don't know whether you can force perl to do something like this, but if 
somebody were to try...

		Linus

