Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266485AbUBFVwp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 16:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266898AbUBFVwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 16:52:45 -0500
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:31946 "HELO
	leia-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S266485AbUBFVwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 16:52:33 -0500
X-Analyze: Velop Mail Shield v0.0.3
Date: Fri, 6 Feb 2004 19:52:29 -0200 (BRST)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
X-X-Sender: fredlwm@pervalidus.dyndns.org
To: linux-kernel@vger.kernel.org
Subject: Re: FATAL: Kernel too old
In-Reply-To: <20040206152943.B26348@discworld.dyndns.org>
Message-ID: <Pine.LNX.4.58.0402061948590.2139@pervalidus.dyndns.org>
References: <Pine.LNX.4.53.0402061550440.681@chaos> <20040206152943.B26348@discworld.dyndns.org>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Feb 2004, Charles Cazabon wrote:

> Richard B. Johnson <root@chaos.analogic.com> wrote:

Hmm, getmail's author doing this :-) ?

> > Script started on Fri Feb  6 15:44:32 2004
> > # rlogin -l johnson quark
> > ATAL: kernel too old
> > # rlogin -l johnson quark
> > ATAL: kernel too old
>
> I saw something similar at a customer's site, when someone rooted the box and
> replaced the default login shell with a rootkitted/backdoored one in a newer
> executable format not supported by the old kernel.

I think it's also what you get if you compile glibc with, say,
--enable-kernel=2.4.20 and boot 2.4.19 and earlier. But in your
case, probably the above.

-- 
http://www.pervalidus.net/contact.html
