Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265030AbTIIXBa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 19:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265040AbTIIXBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 19:01:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:61349 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265030AbTIIXBC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 19:01:02 -0400
Date: Tue, 9 Sep 2003 16:07:40 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@suse.cz>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] Patrick: which part of "maintainer" and "peer review" needs
 explaining to you?
In-Reply-To: <20030909225410.GD211@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0309091604070.695-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I do think this is a bit complicated. I believe passing level, along
> with type of the suspend (aka swsusp vs. S4bios) should be enough.

What about suspend-to-ram, APM, and runtime states? 

That actually makes it quite a bit more complicated, globally. By forcing 
the policy down to the drivers, you force each one to interpret the value 
themselves and make the decision. By doing it centrally, the only thing 
the low-level drivers have to worry about is going into the state. 


	Pat

