Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVGKI5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVGKI5P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 04:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVGKI5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 04:57:15 -0400
Received: from [203.171.93.254] ([203.171.93.254]:65421 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261398AbVGKI5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 04:57:14 -0400
Subject: Re: [PATCH] [30/48] Suspend2 2.1.9.8 for 2.6.12:
	607-atomic-copy.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050710180152.GB10904@elf.ucw.cz>
References: <11206164393426@foobar.com> <11206164423235@foobar.com>
	 <20050710180152.GB10904@elf.ucw.cz>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121072336.7502.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 11 Jul 2005 18:58:56 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2005-07-11 at 04:01, Pavel Machek wrote:
> Hi!
> 
> > --- 608-compression.patch-old/kernel/power/suspend2_core/compression.c	1970-01-01 10:00:00.000000000 +1000
> > +++
> > 608-compression.patch-new/kernel/power/suspend2_core/compression.c
>                                          ~~~~~~~~~~~~~
> 
> suspend2_core looks like an extremely bad name for a directory... And
> this is really plugin, not a core, no? Plus it would be nice to drop
> non-essential stuff for initial submit, so that it is not *that* big
> to review.

Suspend2_core was just to keep things nicely separated for the moment.
I've already shifted everything into kernel/power after Pekka's email.

Regarding non essential stuff, the compression and encryption parts are
really quite small. LZF Compression doubles the speed, and encryption is
considered important by people who care about security. It also helps
you see why the plugin stuff is useful. Of course plugin isn't really
the right name anymore - it's more of an internal api.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

