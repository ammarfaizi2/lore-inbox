Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWELXej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWELXej (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWELXej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:34:39 -0400
Received: from [24.85.144.101] ([24.85.144.101]:50340 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S1750796AbWELXei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:34:38 -0400
Date: Fri, 12 May 2006 16:34:20 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>, trenn@suse.de,
       thoenig@suse.de, stable@kernel.org
Subject: Re: [patch] smbus unhiding kills thermal management
In-Reply-To: <44645FC2.80500@gmx.net>
Message-ID: <Pine.LNX.4.64.0605121547090.27910@montezuma.fsmlabs.com>
References: <20060512095343.GA28375@elf.ucw.cz> <44645FC2.80500@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2006, Carl-Daniel Hailfinger wrote:

> Pavel Machek wrote:
> > Do not enable the SMBus device on Asus boards if suspend
> > is used. We do not reenable the device on resume, leading to all sorts
> > of undesirable effects, the worst being a total fan failure after
> > resume on Samsung P35 laptop.
> > 
> > Signed-off-by: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
> > Signed-off-by: Pavel Machek <pavel@suse.cz>
> 
> This is probably also -stable material.

Isn't it inevitable that we're going to have to rerun quirks on resume on 
some hardware?
