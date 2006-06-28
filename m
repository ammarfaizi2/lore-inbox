Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932712AbWF1Dnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932712AbWF1Dnu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 23:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932687AbWF1Dnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 23:43:50 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:26925 "EHLO
	asav10.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S932712AbWF1Dnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 23:43:49 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FAP+VoUSBSg
From: Dmitry Torokhov <dtor@insightbb.com>
To: Eric Sesterhenn <snakebyte@gmx.de>
Subject: Re: [Patch] Overrun in drivers/input/joystick/db9.c
Date: Tue, 27 Jun 2006 23:43:01 -0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com
References: <1151446574.15289.7.camel@alice>
In-Reply-To: <1151446574.15289.7.camel@alice>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606272343.02309.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 June 2006 18:16, Eric Sesterhenn wrote:
> hi,
> 
> coverity spotted this overrun (#id 483), we assign 
> db9_mode = &db9_modes[mode]; some lines before, so
> if we use mode as index again we might get past the
> array once mode is greater than DB9_MAX_PAD/2,
> besides this this patch changes the code to what
> the author possibly intended it to do.
>

Applied, thank you.

-- 
Dmitry
