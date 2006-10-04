Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWJDUat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWJDUat (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 16:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWJDUat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 16:30:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4224 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751105AbWJDUas (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 16:30:48 -0400
Date: Wed, 4 Oct 2006 13:19:03 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jean Tourrilhes <jt@hpl.hp.com>
cc: "John W. Linville" <linville@tuxdriver.com>, Jeff Garzik <jeff@garzik.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Norbert Preining <preining@logic.at>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johannes@sipsolutions.net
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
In-Reply-To: <Pine.LNX.4.64.0610041311420.3952@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0610041316500.3952@g5.osdl.org>
References: <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org>
 <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org>
 <20061003214038.GE23912@tuxdriver.com> <Pine.LNX.4.64.0610031454420.3952@g5.osdl.org>
 <20061004181032.GA4272@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041133040.3952@g5.osdl.org>
 <20061004185903.GA4386@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041216510.3952@g5.osdl.org>
 <20061004195229.GA4459@bougret.hpl.hp.com> <Pine.LNX.4.64.0610041311420.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



In other words, if we really have had the code to handle both interfaces 
in the kernel, I vote for just reverting the patch that "fixed" it to just 
one.

But I suspect that's not what you're really saying. I think you're saying 
is that we've had two different interfaces for _different_ chips, and that 
some user-space tools have supported both. And since clearly the distros 
haven't updated to those tools yet (or this wouldn't be an issue), we 
still want to avoid a flag-day, and wait until they have done so.

			Linus
