Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVCMUC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVCMUC5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 15:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVCMUC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 15:02:57 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60568 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261443AbVCMUC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 15:02:56 -0500
Date: Sun, 13 Mar 2005 21:02:28 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: Stas Sergeev <stsp@aknet.ru>, Alan Cox <alan@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: [patch] x86: fix ESP corruption CPU bug
Message-ID: <20050313200227.GA8231@elf.ucw.cz>
References: <42348474.7040808@aknet.ru> <Pine.LNX.4.62.0503131950190.23588@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0503131950190.23588@alpha.polcom.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Attached patch works around the corruption
> >of the high word of the ESP register, which
> >is the official bug of x86 CPUs. The bug
> >triggers only when the one is using the
> >16bit stack segment, and is described here:
> >http://www.intel.com/design/intarch/specupdt/27287402.PDF
> 
> Does the bug also egsist on AMD CPU's? Does the patch add anything to 
> kernels compiled for AMD CPU's?

Yes, same workaround is needed on AMDs, Cyrixes, ...

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
