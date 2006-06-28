Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932774AbWF1Lbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932774AbWF1Lbh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 07:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932777AbWF1Lbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 07:31:37 -0400
Received: from baardmijt.demon.nl ([212.238.157.49]:46259 "EHLO
	baardmijt.demon.nl") by vger.kernel.org with ESMTP id S932774AbWF1Lbg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 07:31:36 -0400
Date: Wed, 28 Jun 2006 13:31:28 +0200
From: Tim Dijkstra <newsuser@famdijkstra.org>
To: linux-kernel@vger.kernel.org
Cc: suspend2-devel@lists.suspend2.net
Subject: Re: [Suspend2-devel] Re: Suspend2 - Request for review & inclusion
 in	-mm
Message-ID: <20060628133128.09983d2f@orfeo.nikhef.nl>
In-Reply-To: <1e1a7e1b0606280228y6c4a0d19p12f8112d216d1aba@mail.gmail.com>
References: <200606270147.16501.ncunningham@linuxmail.org>
	<20060627133321.GB3019@elf.ucw.cz>
	<44A14D3D.8060003@wasp.net.au>
	<200606271940.23934.jaroslav@aster.pl>
	<1e1a7e1b0606280228y6c4a0d19p12f8112d216d1aba@mail.gmail.com>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -5.3
X-Spam-Report: ---- Start SpamAssassin results
	-5.3 points, 5.0 required
	-3.3 ALL_TRUSTED            Passed through trusted hosts only via SMTP
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.6 AWL                    AWL: From: address is in the auto white-list
	---- End of SpamAssassin results
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006 19:28:17 +1000
James <iphitus@gmail.com> wrote:

> People dont want promises of something working soon, they want it
> working now. And it's not like suspend2 is a half baked hack, it works
> well for more people than any other solution and works reliably. It's
> going to be months, if not years before uswsusp is ready, working, and
> as feature complete as suspend2 is now, whereas suspend2 has been
> working for me for more than 2 years.

First of all, I have nothing against suspend2, and I think the relevant people
should judge it fairly. I don't understand however why people in this thread 
keep implying that uswsusp doesn't work. On all three machines I tested it on, 
it worked fine.

It is true maybe that it is less feature complete, but the only major drawback
that the current uswsusp implementation has at the moment (IMHO) is that it only 
supports writing to swap.

I think one important reason why people have good experiences with suspend2, is 
because it comes with a nice hibernate script, which has a module blacklist.
This list will hide the fact that some drivers will make your system hang, and
that is independent of the suspend2 or uswsusp.

The CVS version of the hibernate script has some support for uswsusp btw.

grts Tim
