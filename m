Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965198AbVKPDOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965198AbVKPDOs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 22:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965199AbVKPDOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 22:14:47 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:14071 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S965198AbVKPDOq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 22:14:46 -0500
Date: Tue, 15 Nov 2005 20:15:20 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Andrey Volkov <avolkov@varma-el.com>
Cc: Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org,
       linux-kernel@vger.kernel.org, "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 1/1] Added support of ST m41t85 rtc chip
Message-ID: <20051116031520.GL5546@mag.az.mvista.com>
References: <4378960F.8030800@varma-el.com> <20051115215226.4e6494e0.khali@linux-fr.org> <437A57CB.8090302@varma-el.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437A57CB.8090302@varma-el.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 12:48:59AM +0300, Andrey Volkov wrote:

<snip>

> > 
> > Mark, care to comment on that possibility, and/or on the code itself?
> > 
> And, please, remove unnecessary PPC dependence from Kconfig.

When I originally submitted the m41t00 patch, I made it clear that it
was PPC only and gave the reason why:

http://archives.andrew.net.au/lm-sensors/msg29280.html

What processor arch did you test your m41t85 driver on?
AFAICT, PPC is the only arch that uses that exact definition of
get/set_rtc_time().

Mark
