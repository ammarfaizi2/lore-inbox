Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272914AbTG3O4V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 10:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272927AbTG3Ozx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 10:55:53 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:57092 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S272914AbTG3Ozl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 10:55:41 -0400
Date: Wed, 30 Jul 2003 16:55:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: dgp85@users.sourceforge.net, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] LIRC drivers for 2.6.0-test2 (and earliers) - 3rd version
Message-ID: <20030730145538.GB10276@atrey.karlin.mff.cuni.cz>
References: <20030729173846.GB2601@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030729173846.GB2601@openzaurus.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> You can download it from here
> http://flameeyes.web.ctonet.it/patch-2.6.0-test2-lirc.diff.bz2.
> Sorry for not inlining it but it seens too big to be sent to lkml.
> 
> This version fixes problems using lirc_dev as a module (it needs to be
> compiled in the kernel), merges the patch that Koos Vriezen sent to me
> for homebrew receivers, the lirc's cvs fixes for lirc_serial, and add
> the new atiusb driver (from lirc's cvs).
> I'm trying to rejoin the i2c driver but it need more work.
> I hope this patch will work for everyone.

It does not look that bad. Perhaps you can separate that one lirc
driver that you can test, and attempt to get it merged?

Perhaps btXXX driver is the one most commonly needed?
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
