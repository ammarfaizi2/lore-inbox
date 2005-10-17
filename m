Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbVJQRJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbVJQRJy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 13:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbVJQRJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 13:09:54 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20939 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751035AbVJQRJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 13:09:50 -0400
Date: Mon, 17 Oct 2005 12:01:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: 2.6.14-rc1-mm1: usb breaks suspend
Message-ID: <20051017100134.GA1764@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

In -mm, usb breaks suspend to disk. Compiled without
CONFIG_USB_SUSPEND, it just plainly fails; iwth USB_SUSPEND, it
actually tries to suspend USB, but it fails and machine refuses to
suspend. Is it known or is it worth debugging?
								Pavel
-- 
Thanks, Sharp!
