Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264513AbUEELJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264513AbUEELJv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 07:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264522AbUEELJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 07:09:51 -0400
Received: from gprs214-31.eurotel.cz ([160.218.214.31]:48768 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264513AbUEELJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 07:09:50 -0400
Date: Wed, 5 May 2004 13:09:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Romano Giannetti <romano@dea.icai.upco.es>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp documentation updates
Message-ID: <20040505110940.GD1361@elf.ucw.cz>
References: <20040505094719.GA4259@elf.ucw.cz> <20040505110020.GA21005@pern.dea.icai.upco.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040505110020.GA21005@pern.dea.icai.upco.es>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'd like this to be included. People ask question I should have
> > answered in the documentation.
> 
> > +
> > +Q: Does linux support ACPI S4?
> > +
> > +A: No.
> > +
> 
> ...that is auite surprising, meaning that I haven't understood anything till
> now. I have a Sony vaio (http://perso.wanadoo.es/r_mano/vaio/vaio.html),
> with ACPI compiled in, and I did suspend with echo 4 > /proc/acpi/sleep...
> 
> ...retreating in my shell... 

No, echo 4 > /proc/acpi/sleep should suspend your machine; but it will
not be true "ACPI S4" sleep. It is just suspend to disk. ACPI thinks
machine is in S5.

								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
