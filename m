Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWEQNY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWEQNY6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 09:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWEQNY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 09:24:58 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24754 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932266AbWEQNY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 09:24:57 -0400
Date: Wed, 17 May 2006 15:24:08 +0200
From: Pavel Machek <pavel@suse.cz>
To: Bill Davidsen <davidsen@tmr.com>
Cc: marekw1977@yahoo.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: acpi4asus
Message-ID: <20060517132408.GD8065@elf.ucw.cz>
References: <20060511130743.GG15876@mail.muni.cz> <20060511073211.1da40329.akpm@osdl.org> <200605121116.11930.marekw1977@yahoo.com.au> <44649A2E.4070803@tmr.com> <20060508234723.GB4349@ucw.cz> <446A9AD0.6030509@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <446A9AD0.6030509@tmr.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 16-05-06 23:38:56, Bill Davidsen wrote:
> Pavel Machek wrote:
> 
> >Hi!
> >
> > 
> >
> >>>I am far from qualified to comment on this, but from a 
> >>>users point of view, is it possible to not have laptop 
> >>>specific code in the kernel?
> >>>I have had two Linux laptops and with both I had ACPI 
> >>>issues.
> >>>The vendors of both laptops (Toshiba Tecra S1 and now 
> >>>an Asus W3V) don't seem to be following standards. With 
> >>>both I seem to need to patch ACPI to get various 
> >>>functions of the laptop to work.
> >>>I would love to see laptop specific functionality 
> >>>definitions exist outside the kernel.
> >>>
> >>>     
> >>>
> >>I don't think that forcing laptop users to have their 
> >>own code outside the kernel is really the best approach 
> >>for either the developers or the users. Most users will 
> >>   
> >>
> >
> >No, we don't want that. But we do not want ibm-acpi, toshiba-acpi,
> >asus-acpi, etc, when they really only differ in string constants used.
> >
> >We want userland to tell kernel 'mail led is controlled by AML routine
> >foo', instead of having gazillion *-acpi modules.
> >
> >
> > 
> >
> I see no reason why an interface to that couldn't be included in the 
> kernel, with just a small table for each hardware instead of a whole 
> module. Kind of a white list with detail.

I guess that would be acceptable solution.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
