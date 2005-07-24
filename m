Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVGXGIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVGXGIj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 02:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbVGXGIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 02:08:39 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:30404 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261593AbVGXGIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 02:08:38 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reset VGA adapters via BIOS on resume... (non-fbdev/con) 
In-reply-to: Your message of "Sat, 23 Jul 2005 08:53:00 +0200."
             <42E1E94C.3000703@stesmi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 24 Jul 2005 16:08:06 +1000
Message-ID: <3901.1122185286@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jul 2005 08:53:00 +0200, 
Stefan Smietanowski <stesmi@stesmi.com> wrote:
>Pavel Machek wrote:
>> Well, we have debugged with beeps, but... It would be cool if someone
>> got usb debug mode working but... and there are hardware debuggers.
>
>If kdb is your thing then SGI has gotten kdb work over USB using
>OHCI chipsets. They haven't done UHCI (Yet?).

SGI systems only use OHCI, so we have not done UHCI support in KDB.  If
anybody wants to do the work for UHCI and send me a working patch, that
patch will be included in KDB.

