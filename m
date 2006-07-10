Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWGJJoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWGJJoW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 05:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWGJJoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 05:44:21 -0400
Received: from mail.df.lth.se ([194.47.250.12]:29362 "EHLO df.lth.se")
	by vger.kernel.org with ESMTP id S1751374AbWGJJoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 05:44:21 -0400
Date: Mon, 10 Jul 2006 11:44:14 +0200
From: Fredrik Roubert <roubert@df.lth.se>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: Magic Alt-SysRq change in 2.6.18-rc1
Message-ID: <20060710094414.GD1640@igloo.df.lth.se>
Mail-Followup-To: Alan Stern <stern@rowland.harvard.edu>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0607091657490.28904-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0607091657490.28904-100000@netrider.rowland.org>
User-Agent: Mutt/1.4.2.1i
X-PGP-Public-Key: http://www.df.lth.se/~roubert/pubkey.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 09 Jul 23:06 CEST 2006, Alan Stern wrote:

> Before 2.6.18-rc1, I used to be able to use it as follows:
>
> 	Press and hold an Alt key,
> 	Press and hold the SysRq key,
> 	Release the Alt key,
> 	Press and release some hot key like S or T or 7,
> 	Repeat the previous step as many times as desired,
> 	Release the SysRq key.
>
> This scheme doesn't work any more,

The SysRq code has been updated to make it useable with keyboards that
are broken in other ways than your. With the new behaviour, you should
be able to use Magic SysRq with your keyboard in this way:

	Press and hold an Alt key,
	Press and release the SysRq key,
	Press and release some hot key like S or T or 7,
	Repeat the previous step as many times as desired,
	Release the Alt key.

Does that work for you?

Cheers // Fredrik Roubert

-- 
Visserij 192  |  +32 473 344527 / +46 708 776974
BE-9000 Gent  |  http://www.df.lth.se/~roubert/
