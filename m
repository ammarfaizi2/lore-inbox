Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbTEIH5G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 03:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262348AbTEIH5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 03:57:06 -0400
Received: from denise.shiny.it ([194.20.232.1]:21958 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S262343AbTEIH5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 03:57:06 -0400
Message-ID: <XFMail.20030509100906.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <1052437191.1205.4.camel@torrey.et.myrio.com>
Date: Fri, 09 May 2003 10:09:06 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Torrey Hoffman <thoffman@arnor.net>
Subject: RE: ALSA busted in 2.5.69
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 08-May-2003 Torrey Hoffman wrote:
> ALSA isn't working for me in 2.5.69.  It appears to be because
> /proc/asound/dev is missing the control devices.
> open("/dev/snd/controlC0", O_RDWR)      = -1 ENOENT (No such file or
> directory)
> [...]

If you are not using devfs, you need to create the devices. There is a
script in the ALSA-driver package to do that. Otherwise I can't help
you because I never tried devfs and linux 2.5.x.


Bye.

