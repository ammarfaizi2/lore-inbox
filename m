Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbULJPf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbULJPf7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 10:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbULJPf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 10:35:58 -0500
Received: from mail.convergence.de ([212.227.36.84]:8606 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S261735AbULJPfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 10:35:32 -0500
Message-ID: <41B9C1F9.8000401@linuxtv.org>
Date: Fri, 10 Dec 2004 16:34:17 +0100
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH][DVB][0/6] DVB subsystem update
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Andrew,

as promised here comes a set of 6 patches against -rc3-bk3 that brings 
the DVB subsystem in sync with the LinuxTV.org CVS repository.

The most important stuff is inside 4/6 and 5/6. The frontend code has 
been simplified and support for some cards has been fixed.

There is a new firmware for the dvb-ttpci driver out there, which 
improves stability with digital videorecorder applications. The BC2C 
driver has been split up, because there are now USB based devices out 
there. The dib-usb driver now supports more devixces with other 
frontends out there, so the patch is fairly large.

Detailed descriptions are at the top of each patch.

Please apply before 2.6.10. Thanks!

Regards
Michael Hunold.

