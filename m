Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270230AbTGMLpp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 07:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270231AbTGMLpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 07:45:45 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:8884 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S270230AbTGMLpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 07:45:44 -0400
Date: Sun, 13 Jul 2003 14:00:16 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Flameeyes <dgp85@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] LIRC drivers for 2.5.74 - 2nd version
Message-ID: <20030713120016.GB371@elf.ucw.cz>
References: <1057878716.24943.19.camel@laurelin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057878716.24943.19.camel@laurelin>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Here (http://flameeyes.web.ctonet.it/patch-2.5.74-lirc.diff.bz2) there
> is the second version of my patch that adds the LIRC
> (http://lirc.sf.net/) drivers to 2.5 kernels (this patch was prepared
> using 2.5.74 kernel, but it should work also with earlier kernels).

If you want that patch to go in, you should post it here, plaintext.

> In this version I removed the lirc_i2c driver that need the i2c driver
> code from lm_sensors, and therefor is not compatible with 2.5 (I don't
> know how to make it works sorry).
> I also corrected the Makefile as told me by Boszormenyi Zoltan, and also
> merged his patch for MOD_[INC|DEC]_USE_COUNT.

Actually, 2.5 includes a *lot* of lm_sensors code. If there's
something else from lm_sensors thats needed, it should be easy to
port. [I thought lirc_i2c driver was the only interesting one?]
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
