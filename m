Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWA1IMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWA1IMQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 03:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbWA1IMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 03:12:16 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42725 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964836AbWA1IMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 03:12:15 -0500
Date: Sat, 28 Jan 2006 09:12:05 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Suspend to RAM: help with whitelist wanted
Message-ID: <20060128081204.GA1605@elf.ucw.cz>
References: <20060126213611.GA1668@elf.ucw.cz> <20060127170406.GA6164@dreamland.darkstar.lan> <20060127230535.GA1617@elf.ucw.cz> <20060128010524.GA59822@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060128010524.GA59822@dspnet.fr.eu.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On So 28-01-06 02:05:25, Olivier Galibert wrote:
> On Sat, Jan 28, 2006 at 12:05:35AM +0100, Pavel Machek wrote:
> > I originally wanted to avoid calling external problems. That way,
> > s2ram code could be pagelocked and you would get your video back even
> > in case of disk problems etc.
> 
> You should not add yet another program that does video card accesses
> from userspace.  The xorg and fbdev developpers are having a hard

There's no other solution, sorry. xorg are not even involved -- we do
it on text console. And unless you want x86 emulator in kernel, we
need something to restore our video in userspace.
								Pavel
-- 
Thanks, Sharp!
