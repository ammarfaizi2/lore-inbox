Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261954AbSJISoz>; Wed, 9 Oct 2002 14:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261951AbSJISoU>; Wed, 9 Oct 2002 14:44:20 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55815 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261954AbSJISm5>; Wed, 9 Oct 2002 14:42:57 -0400
Date: Wed, 9 Oct 2002 11:47:16 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: linux kernel conf 0.8
In-Reply-To: <20021009195531.B1708@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0210091141360.14464-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Oct 2002, Sam Ravnborg wrote:
> 
> ls rrunner*
> should show me not only the implementation [.c + .h] but also
> the configuration.

I agree with you, but only if we _always_ have one config file per driver. 

Which is not necessarily the wrong thing to do. 

But as long as most drivers are in "grouped" config files, they should be 
things like "Config.3com" etc.

Looking at existing big config files (video, networking), they do _not_ 
group according to driver, but according to other criteria (ie "PCI card", 
"100/1000 Mbit", "3com", "Sparc-specific" etc).

		Linus


