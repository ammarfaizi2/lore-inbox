Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbUKHVij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbUKHVij (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 16:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbUKHVij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 16:38:39 -0500
Received: from gprs214-14.eurotel.cz ([160.218.214.14]:41858 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261247AbUKHVic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 16:38:32 -0500
Date: Mon, 8 Nov 2004 22:38:15 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Michal Semler <cijoml@volny.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsuspend and total loss of all data :(((
Message-ID: <20041108213815.GD4607@elf.ucw.cz>
References: <200411040126.27613.cijoml@volny.cz> <20041104130228.GE996@openzaurus.ucw.cz> <200411081624.52149.cijoml@volny.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200411081624.52149.cijoml@volny.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 2.6.9 with -mh3 patches

Okay, that is not that ancient. Can you reproduce it? You should
probably remount your filesystems read only and use ext2 (not ext3) as
a safety precaution.
								Pavel

> Dne čt 4. listopadu 2004 14:02 Pavel Machek napsal(a):
> > Hi!
> >
> > > I hibernated without BT donle (CSR based 16.1.1 fw)  plugged into USB
> > > port and started with it plugged in and kernel after successfully loaded
> > > image from hdd freezes saying USB device plugged in and info about usb
> > > port...
> > >
> > > After press reset kernel started recovering ext3 fs, but all my data are
> > > lost...
> > >
> > > PLS fix it in future releases
> >
> > Hmm, which kernel was it? Any patches applied?
> >     Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
