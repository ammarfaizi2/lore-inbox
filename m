Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbVLDX7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbVLDX7E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 18:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbVLDX7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 18:59:04 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:65424 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932288AbVLDX7D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 18:59:03 -0500
Date: Mon, 5 Dec 2005 00:59:04 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>
Message-ID: <20051204235904.GB7478@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Jean Delvare <khali@linux-fr.org>,
	Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
	Linus Torvalds <torvalds@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>,
	LM Sensors <lm-sensors@lm-sensors.org>,
	Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>
References: <20051202192814.282fc10c.khali@linux-fr.org> <1133602035.6724.5.camel@localhost> <20051203124715.52f8d736.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051203124715.52f8d736.khali@linux-fr.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: 84.189.217.138
Subject: Re: Incorrect v4l patch in 2.6.15-rc4-git1
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2005, Jean Delvare wrote:
> I'll go undefine these experimental IDs soon anyway, as the concept is
> broken IMHO. If driver authors don't use the ID, they can set it to 0.
> If they do use it, they better register it soon so as to avoid
> collisions with other drivers which haven't been merged either.

I believe no one actually uses I2C ids in drivers/media/.
Is it documented somewhere that they should be set to 0 when
unused? I believe most people set them to experimental ids
because they fear getting conflicts and malfunctionings when
they leave them at 0.

Johannes
