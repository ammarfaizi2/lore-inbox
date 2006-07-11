Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWGKWVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWGKWVk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWGKWVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:21:40 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:29595 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932204AbWGKWVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:21:38 -0400
Date: Wed, 12 Jul 2006 00:21:31 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Pavel Machek <pavel@ucw.cz>
cc: Fredrik Roubert <roubert@df.lth.se>,
       Alan Stern <stern@rowland.harvard.edu>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: Magic Alt-SysRq change in 2.6.18-rc1
In-Reply-To: <20060711124105.GA2474@elf.ucw.cz>
Message-ID: <Pine.LNX.4.64.0607120016490.12900@scrub.home>
References: <Pine.LNX.4.44L0.0607091657490.28904-100000@netrider.rowland.org>
 <20060710094414.GD1640@igloo.df.lth.se> <Pine.LNX.4.64.0607102356460.17704@scrub.home>
 <20060711124105.GA2474@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 11 Jul 2006, Pavel Machek wrote:

> > Apparently it changes existing well documented behaviour, which is a 
> > really bad idea.
> 
> _well documented_? Where was it documented? Anyway, 2.6.17 behaviour
> does not work on _many_ keyboards, like for example thinkpad x32...

Documentation/sysrq.txt and this was working on _many_ more keyboards just 
fine.
The fact is this patch changes existing behaviour, it either needs to be
fixed or reverted. Adding new features is one thing, breaking existing 
features is not acceptable without a very good reason.

bye, Roman
