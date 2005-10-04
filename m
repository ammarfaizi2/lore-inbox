Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbVJDMBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbVJDMBI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 08:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbVJDMBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 08:01:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:6072 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932383AbVJDMBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 08:01:06 -0400
Subject: Re: thinkpad suspend to ram and backlight
From: Timo Hoenig <thoenig@suse.de>
To: Stefan Seyfried <seife@suse.de>
Cc: Pavel Machek <pavel@suse.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <43410149.9070007@suse.de>
References: <20051002175703.GA3141@elf.ucw.cz>  <43410149.9070007@suse.de>
Content-Type: text/plain
Date: Tue, 04 Oct 2005 14:00:14 +0200
Message-Id: <1128427214.14551.15.camel@nouse.suse.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2005-10-03 at 12:00 +0200, Stefan Seyfried wrote:

> Pavel Machek wrote:
> > Hi!
> > 
> > When I suspend to RAM on x32, backlight is not turned off. (And, IIRC,
> > video chips is not turned off, too). Unfortunately, backlight is not
> > turned even when lid is closed. I know some patches were floating
> > around to solve that... but I can't find them now. Any ideas?
> 
> Which framebuffer driver? Vesafb works for Timo, at least he did not
> complain lately ;-)

It's never too late to complain: I just gave it a try with vesfb.
Backlight stays on.

When eying the display precisely it seems to be switched off for a short
moment once the system enters S3 but then gets turned on again.

   Timo

