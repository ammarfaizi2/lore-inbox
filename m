Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbVLPTXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbVLPTXj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 14:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbVLPTXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 14:23:39 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:20650 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932377AbVLPTXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 14:23:39 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Lee Revell <rlrevell@joe-job.com>
To: 7eggert@gmx.de
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org, Alex Davis <alex14641@yahoo.com>
In-Reply-To: <E1EnDOo-0006Gd-Na@be1.lrz>
References: <5kh6K-7KC-3@gated-at.bofh.it> <5kiFR-1mi-11@gated-at.bofh.it>
	 <E1EnDOo-0006Gd-Na@be1.lrz>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 14:25:57 -0500
Message-Id: <1134761158.18119.9.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-16 at 12:05 +0100, Bodo Eggert wrote:
> Kyle Moffett <mrmacman_g4@mac.com> wrote:
> 
> > Enough already!  These concerns have been raised already, and found
> > to be insufficient.  There are several points:
> > 
> > 1)    ndiswrapper is broken already, and works sheerly by luck anyways;
> > NT stacks are 12kb, so you're already asking for stack overflows by
> > using it.
> > 2)    ndiswrapper encourages use of binary drivers instead of the open-
> > source ones that need the testers, so you're only hurting yourselves
> > in the long run.
> 
> ACK. So where is the driver for the Netgear WG511 Softmac card I'm supposed
> to test? I bought this card because it was labled as being supported, and it
> turned out that it wasn't, and just nobody cared to update the list of
> supported cards with the warning about the unsupported variant.

Um, this is not the developers fault.  Do you think the vendors call the
driver developers to tell them "hey, we just released a new product,
with a name confusingly similar to the one your driver supports, but we
changed the chipset a tiny bit so it won't work with your driver"?
Dream on.

Driver developers are not psychic.  If no USER reported that the new
FooBar1002X is completely different from the FooBar1002, there's no way
for us to know.  Sorry you were unfortunate enough to be the first user
to learn the hard way.  Complain to the vendor not LKML.

Lee

