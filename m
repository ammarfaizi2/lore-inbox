Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWATQrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWATQrf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWATQrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:47:35 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:33435 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1751086AbWATQre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:47:34 -0500
Date: Fri, 20 Jan 2006 17:48:27 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: dtor_core@ameritech.net
Cc: Marc Koschewski <marc@osknowledge.org>, Michael Loftis <mloftis@wgops.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <20060120164827.GD5873@stiffy.osknowledge.org>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com> <20060120155919.GA5873@stiffy.osknowledge.org> <d120d5000601200840o704af2e5h6d9087b62594bbe1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000601200840o704af2e5h6d9087b62594bbe1@mail.gmail.com>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc1-marc-g18a41440-dirty
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dmitry Torokhov <dmitry.torokhov@gmail.com> [2006-01-20 11:40:42 -0500]:

> On 1/20/06, Marc Koschewski <marc@osknowledge.org> wrote:
> >
> > For my daily work I use the -git kernels on my production machines. And I didn't
> > have probs for a long time due to stuff being tested in -mm. -mm is mostly
> > broken for me (psmouse, now reiserfs, ...) but I tend to say that 2.6 is
> > rock-stable.
> >
> 
> [Trying to steal the thread somewhat...]
> 
> Marc, have you tried 2.6.16-rc1 yet? Does it also give you problems
> with psmouse?
> 

Not yet, Dmitry. I just managed to get today's -git compiled and running. I'll
give it a try tonite.

Moreover, I put a

	echo -n 0 > /sys/bus/serio/devices/serio0/resync_time

in my initscripts. Since then I didn't see any problem. I'll report later how it
went with that line removed and stock 2.6.16-rc1.

Marc
