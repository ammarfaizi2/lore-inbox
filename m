Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275360AbTHITOn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 15:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275373AbTHITOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 15:14:43 -0400
Received: from smtp2.libero.it ([193.70.192.52]:27022 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id S275360AbTHITOl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 15:14:41 -0400
Subject: Re: [PATCH] lirc for 2.5/2.6 kernels - 20030802
From: Flameeyes <dgp85@users.sourceforge.net>
To: Pavel Machek <pavel@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LIRC list <lirc-list@lists.sourceforge.net>
In-Reply-To: <20030807214311.GC211@elf.ucw.cz>
References: <1059820741.3116.24.camel@laurelin>
	 <20030807214311.GC211@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1060456500.12363.2.camel@defiant.flameeyes>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 09 Aug 2003 21:15:01 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-07 at 23:43, Pavel Machek wrote:
> * What does "For now don't try to use as static version" comment in
>   lirc_gpio mean. Does it only work as a module?
Ok i've tested it out. If i'll build in-kernel bttv and pass to kernel
the parameters for the card, lirc_gpio is checked before the bttv itself
and result in an error.
It need to be built as a module, always.

-- 
Flameeyes <dgp85@users.sf.net>

