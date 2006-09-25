Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWIYNYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWIYNYU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 09:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbWIYNYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 09:24:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57729 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750747AbWIYNYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 09:24:19 -0400
Subject: Re: [PATCH] v4l2 VIDIOC_DQBUF typo in 2.6.18
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, stable@kernel.org,
       s.hauer@pengutronix.de
In-Reply-To: <8056.1159189100@lwn.net>
References: <8056.1159189100@lwn.net>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 25 Sep 2006 10:24:10 -0300
Message-Id: <1159190650.10332.93.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jonathan,

Em Seg, 2006-09-25 às 06:58 -0600, Jonathan Corbet escreveu:
> It seems that, in the rush to create the new V4L2 ioctl() API, the
> VIDIOC_DQBUF code got cut-and-pasted in without being fixed up.
Yes.
> I went and made a patch, only to discover that Sascha Hauer beat me to it.
It is already corrected at my -git tree and at V4L/DVB development tree,
available at http://linuxtv.org/hg. The correction is also at -mm
series.

This trouble were discovered too late at 2.6.18 cycle, and affected just
vivi module, used to emulate a v4l2 driver. It is likely to affect just
driver and userspace developers.

> That patch doesn't seem to have been picked up yet, however.  Since it's
> important (streaming I/O will not work without it), here's an attempt to
> spread it a bit more widely.

Cheers, 
Mauro.

