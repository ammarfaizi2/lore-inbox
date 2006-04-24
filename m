Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWDXIyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWDXIyP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 04:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWDXIyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 04:54:15 -0400
Received: from gate.in-addr.de ([212.8.193.158]:52911 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S932091AbWDXIyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 04:54:14 -0400
Date: Mon, 24 Apr 2006 10:54:56 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks)
Message-ID: <20060424085456.GL440@marowsky-bree.de>
References: <20060417195146.GA8875@kroah.com> <1145309184.14497.1.camel@localhost.localdomain> <200604180229.k3I2TXXA017777@turing-police.cc.vt.edu> <4445484F.1050006@novell.com> <20060420211308.GB2360@ucw.cz> <444AF977.5050201@novell.com> <200604230933.k3N9XTZ8019756@turing-police.cc.vt.edu> <20060423145846.GA7495@thorium.jmh.mhn.de> <20060424082831.GI440@marowsky-bree.de> <1145867837.3116.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1145867837.3116.7.camel@laptopd505.fenrus.org>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-04-24T10:37:17, Arjan van de Ven <arjan@infradead.org> wrote:

> > Security models can be compromised by root or by dumb accomplices. Film
> > at eleven.
> well this security model wants to partition root, more or less. So to
> some degree looking at it makes sense; just not so much in the given
> example ;)

True.

> > Seriously, this is not helpful. Could we instead focus on the
> > technical argument wrt the kernel patches?
> I disagree with your stance here; trying to poke holes in the
> mechanism IS useful and important. In addition to looking at the
> kernel patches. 

I agree, sort-of. Yet, I'd argue that the holes tried to poke here rely
on the admin being sloppish not with regular operation, but _while
configuring the security policy_. The only way to protect against that
is to shoot the admin on sight.

Which might not be a bad idea, looking at the stats of the human error
still being the most dangerous detail in any equation, yet it may be
considered impractical.

> I understand your employer wants this merged asap, but that's no reason
> to try to stop discussions that try to poke holes in the security model.

I resent that remark. At the same level I could argue that some other
people in this discussion do have a professional interest in getting it
_not_ merged. (And LSM ripped out _now_ before it gets a chance to
address the comments made so far.) I'd rather not go there. 

But while we're there, just really briefly, it is important to point out
that while Novell/SUSE obviously _does_ have a corporate interest, it is
not required for this to be "ASAP", and I trust that Crispin, Tony et
al will work to incorporate all feedback received. I don't think we're
in any rush, and even if LSM _is_ ripped out, that just means that the
patch series will be augmented with a further patch [01/xx] "Reinstate
LSM hooks w/additional provisions to address code cleanliness."

Going back to the technical side of things, I'd be more happy if the
holes poked were something you could reasonably expect to be able to
protect against.


Sincerely,
    Lars Marowsky-Brée

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

