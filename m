Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVA0XFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVA0XFV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 18:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVA0XEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 18:04:05 -0500
Received: from gprs213-80.eurotel.cz ([160.218.213.80]:64899 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261262AbVA0XBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 18:01:47 -0500
Date: Fri, 28 Jan 2005 00:01:31 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Applications segfault on evo n620c with 2.6.10
Message-ID: <20050127230131.GC1679@elf.ucw.cz>
References: <20050127184334.GA1368@elf.ucw.cz> <1106866666.15825.21.camel@nigelcunningham>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106866666.15825.21.camel@nigelcunningham>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Unfortunately I do not know how to reproduce it. I tried
> > parallel-building kernels for few hours and that worked okay. Swsusp
> > is not involved (but usb, bluetooth, acpi and sound may be).
> 
> I take it you're sure suspending is not involved because it happens
> before you've ever suspended? If you hadn't said that, I'd say it sounds
> very much like something suspend related.

Yes, it happened even in cases when machine was not ever suspended. I
guess I should also add that kernel is "tainted: pavel", (that means I
have my own patches in; but I really believe that my changes are not
responsible).
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
