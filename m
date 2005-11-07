Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbVKGHma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbVKGHma (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 02:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbVKGHma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 02:42:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39559 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932451AbVKGHm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 02:42:29 -0500
Subject: Re: 3D video card recommendations
From: Arjan van de Ven <arjan@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1131112605.14381.34.camel@localhost.localdomain>
References: <1131112605.14381.34.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 07 Nov 2005 08:42:23 +0100
Message-Id: <1131349343.2858.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-04 at 08:56 -0500, Steven Rostedt wrote:
> I'm currently putting together (ordering parts for) another machine. It
> will be a AMD64 X2. Now I'm looking into a video card for this.  Up till
> now, I've always used NVidia.  But I also want to test 3D acceleration
> under Ingo's -rt patch.  So now I need something that does not have a
> priority module.
> 
> I'm not much of a gamer, although I do play every so often. So I don't
> need the highest quality card, but I also want something that is still
> pretty good. For example, I currently have a NVidia GeForce 6800 GT
> card.  So I'm hoping to get something equivalent. 


people who buy a 3D card for linux that depends on a closed source
module take a few risks, and they should be aware of them (I suspect
they are) so let me make some of them explicit:

By buying a piece of hardware that requires a closed module you take the
risk that one of the following can happen at any time

1) The vendor in the future stops considering linux important and you're
stuck with old kernels; for example as a side-effect of getting a good
deal to supply graphics chips to a certain game console maker
2) The vendor in the future stops considering the hardware you bought
important enough to spend time on; after all they got their cash and the
product cycles for consumer hardware are often in the 3 to 6 month
timeframe. Result: you're stuck with old kernels.
3) The vendor gets sued and convicted for GPL violations and stops doing
linux as a result. (not saying it will happen, but it sure is a risk you
are taking)
4) The linux kernel developers change the kernel in a way that the
module in question no longer is possible and the vendor stops updating
the driver
5) The vendor goes out of business and thus stops updating the driver
6) The vendor doesn't release an x86-64 binary (or other architecture)
and your next PC can't use the module anymore
7) The vendor starts charging money for the driver or updates thereof.

Open source is not just something for developers, but also for users. It
means that you or anyone else can keep the open driver going even when
the manufacturer stops doing so. By using a closed driver you get all
the disadvantages of the open source model (yes there are some just that
normally the benefits outweigh them by far) without getting the gains.
Be very sure you want to do this before spending your hard earned money
on hardware that doesn't work without closed drivers.


