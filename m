Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264235AbUEHKYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264235AbUEHKYM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 06:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264238AbUEHKYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 06:24:12 -0400
Received: from sigma.informatik.hu-berlin.de ([141.20.20.51]:50653 "EHLO
	sigma.informatik.hu-berlin.de") by vger.kernel.org with ESMTP
	id S264235AbUEHKYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 06:24:09 -0400
From: Axel =?utf-8?q?Wei=C3=9F?= <aweiss@informatik.hu-berlin.de>
Organization: (zu Hause)
To: linux-kernel@vger.kernel.org
Subject: Re: module-licences / tainting the kernel
Date: Sat, 8 May 2004 12:24:49 +0200
User-Agent: KMail/1.6.2
References: <200405080957.57286.aweiss@informatik.hu-berlin.de> <1084003417.3843.9.camel@laptop.fenrus.com>
In-Reply-To: <1084003417.3843.9.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200405081224.49890.aweiss@informatik.hu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 8. Mai 2004 10:03 schrieb Arjan van de Ven:
> > Would it be possible to let e.g. LPGL-licenced kernel-modules be loaded
> > legally?
>
> there are 2 angles here:
> 1) there already is "GPL with additional rights" which LGPL is just one
> form of

Ok, I didn'd see it before - thx.

> and
> 2) if you mix LGPL with GPL (eg kernel), the LGPL license itself says it
> autoconverts to GPL, so you can't even have a LGPL module *loaded*.
> (Not saying that your source can't be LGPL but when you link it into the
> kernel at runtime it turns GPL)

What does this actually mean (I'm no lawyer and somehow confused about it)? As 
I understand, GPL sais: 'every piece of code that relies on me, must be 
GPL'ed and therefore be available as source code', while LGPL sais: 'you may 
develop proprietary software that relies on me, but if you change me, your 
changes must be available as source code'.

I want to permit proprietary extensions *in user-space* for my 
open-source-project, that contains some device-drivers for DSP-cards, and 
partly relies on them. Does your second statement mean that as long as 
there's only source-code, it may be LGPL (and extendable), but if you *use* 
it (e.g. load the kernel-modules), everything that relies on the modules must 
be GPL?

(If this is OT, please tell me, and excuse the noise)

			Axel
