Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965033AbWGJV7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbWGJV7s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 17:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbWGJV7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 17:59:48 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:56465 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965033AbWGJV7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 17:59:47 -0400
Date: Mon, 10 Jul 2006 23:59:26 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Fredrik Roubert <roubert@df.lth.se>
cc: Alan Stern <stern@rowland.harvard.edu>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: Magic Alt-SysRq change in 2.6.18-rc1
In-Reply-To: <20060710094414.GD1640@igloo.df.lth.se>
Message-ID: <Pine.LNX.4.64.0607102356460.17704@scrub.home>
References: <Pine.LNX.4.44L0.0607091657490.28904-100000@netrider.rowland.org>
 <20060710094414.GD1640@igloo.df.lth.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 10 Jul 2006, Fredrik Roubert wrote:

> > Before 2.6.18-rc1, I used to be able to use it as follows:
> >
> > 	Press and hold an Alt key,
> > 	Press and hold the SysRq key,
> > 	Release the Alt key,
> > 	Press and release some hot key like S or T or 7,
> > 	Repeat the previous step as many times as desired,
> > 	Release the SysRq key.
> >
> > This scheme doesn't work any more,
> 
> The SysRq code has been updated to make it useable with keyboards that
> are broken in other ways than your. With the new behaviour, you should
> be able to use Magic SysRq with your keyboard in this way:

Apparently it changes existing well documented behaviour, which is a 
really bad idea.

bye, Roman
