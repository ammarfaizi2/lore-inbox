Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262462AbVAQKRC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbVAQKRC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 05:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbVAQKRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 05:17:01 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:47253
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262462AbVAQKQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 05:16:55 -0500
Subject: Re: User space out of memory approach
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Edjard Souza Mota <edjard@gmail.com>, Ilias Biris <xyz.biris@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1105907681.12201.3.camel@localhost.localdomain>
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	 <4d6522b9050110144017d0c075@mail.gmail.com>
	 <20050110200514.GA18796@logos.cnet>
	 <1105403747.17853.48.camel@tglx.tec.linutronix.de>
	 <4d6522b90501101803523eea79@mail.gmail.com>
	 <1105433093.17853.78.camel@tglx.tec.linutronix.de>
	 <1105461106.16168.41.camel@localhost.localdomain>
	 <4e1a70d1050111111614670f32@mail.gmail.com>
	 <4e1a70d10501111246391176b@mail.gmail.com>
	 <1105630523.4644.52.camel@localhost.localdomain>
	 <4d6522b90501160206306b0140@mail.gmail.com>
	 <1105907681.12201.3.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 17 Jan 2005 11:16:54 +0100
Message-Id: <1105957014.13265.378.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-16 at 21:10 +0000, Alan Cox wrote:
> On Sul, 2005-01-16 at 10:06, Edjard Souza Mota wrote:
> > What do you think about the point we are trying to make, i.e., moving the
> > ranking of PIDs to be killed to user space? Or, making user have some influence
> > on it? We were misunderstood because the patch we sent was to make "a slight"
> > organization in the way OOM killer compute rates to PIDs, not to change its
> 
> Im sceptical there is an answer but moving it to user space (or at least
> implementing /proc tunables in user space to experiment) certainly seems
> to be the right way to find out.

No objections against an userspace tuning mechanism, but I still doubt
that replacing the always imperfect in kernel selection completely is
feasable.

tglx


