Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264442AbUAIVi5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 16:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264445AbUAIVi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 16:38:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:36059 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264442AbUAIViO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 16:38:14 -0500
Date: Fri, 9 Jan 2004 13:35:18 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Ian Pilcher <i.pilcher@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl equivalent of "idle=poll"
Message-Id: <20040109133518.59c44790.rddunlap@osdl.org>
In-Reply-To: <3FFBA98D.1080901@comcast.net>
References: <3FFBA98D.1080901@comcast.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Jan 2004 00:39:09 -0600 Ian Pilcher <i.pilcher@comcast.net> wrote:

| The previous version of this patch didn't get any response, so on the
| "no news is good news" theory ... Any comments before I send this off to
| Marcelo?
| 
| This adds a new x86-only sysctl, /proc/sys/kernel/idle_poll, which does
| basically the same thing as the "idle=poll" boot parameter (except that
| it can be turned on and off).
| 
| This patch does not affect the ability of the APM and/or ACPI subsystems
| to override the default idle function.  It adds one symbol,
| pm_idle_poll, to the global namespace.
| 
| This patch applies cleanly to 2.4.23, 2.4.24, and 2.4.25-pre4.

Hi Ian,
Sorry for not replying sooner.

I don't see any problems with this patch itself, other than its
justification.

Why is a sysctl needed instead of using idle=X as a boot parameter?

Does this fix a bug/oops that you were having?
Or does it cover up a bug somewhere?

--
~Randy
MOTD:  Always include version info.
