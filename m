Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbWAYJY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbWAYJY7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 04:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWAYJY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 04:24:59 -0500
Received: from ns.firmix.at ([62.141.48.66]:54146 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1751065AbWAYJY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 04:24:58 -0500
Subject: Re: [RFC] VM: I have a dream...
From: Bernd Petrovitsch <bernd@firmix.at>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Diego Calleja <diegocg@gmail.com>, Ram Gupta <ram.gupta5@gmail.com>,
       mloftis@wgops.com, barryn@pobox.com, a1426z@gawab.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <200601240211.k0O28rnn003165@laptop11.inf.utfsm.cl>
References: <200601240211.k0O28rnn003165@laptop11.inf.utfsm.cl>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Wed, 25 Jan 2006 10:23:53 +0100
Message-Id: <1138181033.4800.4.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-23 at 23:08 -0300, Horst von Brand wrote:
[...]
> Good rule of thumb: If you run into swap, add RAM. Swap is /extremely/ slow
> memory, however fast you make it go. RAM is not expensive anymore...

- Except on laptops where you usually can't add *any* RAM. And if you
  can, it is *much much* more expensive than on "normal" PCs.
- Except if you - for whatever reason - have to throw out smaller RAMs
  to get larger (and much more expensive) RAMs into it.
- Except (as someone else mentioned) you have already equipped your main
  board to the max.

> > You have roughly 2 GB of dynamic address-space avaliable to each
> > task (stuff that's not the kernel and not the runtime libraries).
> 
> Right. But your average task is far from that size, and most of it resides
> in shared libraries and (perhaps shared) executables, and is perhaps even
> COW shared with other tasks.
> 
> > You can easily have 500 tasks,
> 
> Even thousands.
> 
> >                                even RedHat out-of-the-box creates
> > about 60 tasks. That's 1,000 GB of potential swap-space required
> > to support this.

And after login (on XFCE + a few standard tools in my case) > 200.

> But you really never do. That is the point.

ACK. X, evolution and Mozilla family (to name standard apps) are the
exceptions to this rule.

	Bermd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services


