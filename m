Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269517AbUI3VQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269517AbUI3VQs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 17:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269520AbUI3VQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 17:16:30 -0400
Received: from gprs214-214.eurotel.cz ([160.218.214.214]:65153 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S269517AbUI3VOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 17:14:21 -0400
Date: Thu, 30 Sep 2004 23:11:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.9-rc3: USB OHCI failure on suspend on AMD64
Message-ID: <20040930211121.GA30876@elf.ucw.cz>
References: <200409302251.30903.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409302251.30903.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> It seems there's a problem with USB OHCI driver that causes these traces to 
> appear on suspend on an AMD64-based box:

Check if OHCI's suspend/resume method is called correctly and that
OHCI really acts on it.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
