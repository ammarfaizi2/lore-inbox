Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbTFTPZV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 11:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTFTPZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 11:25:20 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7949 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262297AbTFTPZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 11:25:18 -0400
Date: Fri, 20 Jun 2003 08:38:07 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Xavier Bestel <xavier.bestel@free.fr>
cc: Nuno Silva <nuno.silva@vgertech.com>, Samphan Raruenrom <samphan@thai.com>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Crusoe's persistent translation on linux?
In-Reply-To: <1056100114.2978.31.camel@nomade>
Message-ID: <Pine.LNX.4.44.0306200832120.25872-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20 Jun 2003, Xavier Bestel wrote:
> 
> Did you just write: "the Crusoe has special backdoors built-in which
> would allow a userspace program to takeover the machine, and Transmeta
> choose security through obscurity to avoid this problem" ?

No. Quite the reverse. I just effectively wrote "you _cannot_ do that".  
And we won't even tell the details of _how_ you cannot do that.

In fact, even inside transmeta you cannot do that, without having a
specially blessed version of the flash that allows upgrades. If you ever
see a machine with a prominent notice saying "CMS upgraded to development
version", then that's a hint that it's a machine that TMTA developers
could change.

But even then you'd have to know how to change it.

Think of it like the Intel microcode update, except on steroids. Big 
steroids.

		Linus

