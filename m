Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWAEBFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWAEBFk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 20:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWAEBFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 20:05:39 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27868 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750992AbWAEBFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 20:05:39 -0500
Date: Thu, 5 Jan 2006 02:05:05 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       ast@domdv.de, Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [RFC/RFT][PATCH -mm 0/5] swsusp: userland interface (rev. 2)
Message-ID: <20060105010505.GD1751@elf.ucw.cz>
References: <200601042340.42118.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200601042340.42118.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is the second "preview release" of the swsusp userland interface patches.
> They have changed quite a bit since the previous post, as I tried to make the
> interface more robust against some potential user space bugs (or outright
> attempts to abuse it).
> 
> The swsusp userland interface is based on a special character device allowing
> a user space process to initiate suspend or resume using ioctls and to write or read
> the system memory snapshot from the device (actually more operations are
> defined on the device).  The device itself is introduced by the
> second patch.
...
> Any feedback will be very much appreciated.

Pretty please, give it a try. If you think about introducing
splashscreen/compression/encryption into swsusp, userland parts of
these patches should be great place for it.
								Pavel
-- 
Thanks, Sharp!
