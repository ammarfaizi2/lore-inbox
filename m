Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbVC3Oie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbVC3Oie (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 09:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbVC3Oie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 09:38:34 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:48390 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S261917AbVC3Oi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 09:38:27 -0500
Date: Wed, 30 Mar 2005 16:38:26 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Steven Rostedt <rostedt@goodmis.org>,
       floam@sh.nu, LKML <linux-kernel@vger.kernel.org>, arjan@infradead.org,
       Paul Jackson <pj@engr.sgi.com>, gilbertd@treblig.org, bunk@stusta.de
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Message-ID: <20050330143826.GB71637@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Kyle Moffett <mrmacman_g4@mac.com>,
	Steven Rostedt <rostedt@goodmis.org>, floam@sh.nu,
	LKML <linux-kernel@vger.kernel.org>, arjan@infradead.org,
	Paul Jackson <pj@engr.sgi.com>, gilbertd@treblig.org,
	bunk@stusta.de
References: <mrmacman_g4@mac.com> <c4ce304162b3d2a3ad78dc9e0bc455f5@mac.com> <200503291631.j2TGVgUH023709@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503291631.j2TGVgUH023709@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 12:31:42PM -0400, Horst von Brand wrote:
> Sorry, but an /interfase/ is there to do exactly that. It can be placed
> under copyright protection as code, but /using/ it just can't be considered
> a derived work. It makes no sense that if I get a description (docu,
> example code, whatever) and learn from that how it is used, and then go and
> write my own, that my code it should be a derived work of what is at the
> other side of the interfase. 

IANAL, but I've seen two extremes in the interpretation of "derived
work" w.r.t the GPL:

1- If there isn't GPL code in your sources, it's not a derived
   work.  That interpretation would make the GPL and the LGPL
   pretty much equivalent.

2- If you depend on GPL code in any way to make your code useful,
   then it's a derived work.

The truth is, as always, somewhere in the middle, and intentions,
local law and jurisprudence matter a lot when a judge states on a case
like that, whichever your country is.  That's why the "check with a
lawyer in your jurisdiction" is the only appropriate answer.

The FSF stance btw is a little less harsh than 2.  It's pretty much,
from what I understand it, "if you depend on gpl code, and there is no
non-gpl alternative which means you really, really depend on gpl code
no matter what, then it's a derived work.".  Makes a lot of sense too.
Whether it holds water is a matter of the court.  It _is_ the intent
behind the GPL though, they wrote the GPL and said so numerous times,
so it will have its importance if someone puts that part of the GPL to
the test.

You'll notice that I never talk of interfaces in all that.  Interfaces
is a technical matter, and maybe an intent matter[1].  Derived work
status is a _legal_ matter which puts in play dependency and intent.
Not a technical matter at all.

  OG.

[1] Compare for intent differences:
     - "Linux has a sysfs interface, check the sources for how it works"
     - "Here is the sysfs interface documentation for use in the GPL-ed
        Linux kernel"
     - "Here is the sysfs interface documentation, an implementation-neutral
        interface for <whatever>, which happens to be implemented in, among
        others, the Linux kernel".
