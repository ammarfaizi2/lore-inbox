Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbUL3MAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbUL3MAe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 07:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbUL3MAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 07:00:34 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:42474 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S261550AbUL3MAa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 07:00:30 -0500
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 and speedtouch usb
Date: Thu, 30 Dec 2004 13:00:30 +0100
User-Agent: KMail/1.6.2
Cc: Roman Kagan <rkagan@mail.ru>, Serge Tchesmeli <zztchesmeli@echo.fr>
References: <200412271108.47578.zztchesmeli@echo.fr> <20041229161829.GA9076@panda.itep.ru>
In-Reply-To: <20041229161829.GA9076@panda.itep.ru>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200412301300.30105.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It looks like the line status monitoring implemented in the driver in
> 2.6.10 interferes with that in modem_run.  Unless you have a reason to
> keep using modem_run, you can let it go and use the line status
> monitoring and firmware loading facilities provided by the driver
> itself.  Just follow Andrew's advice.

Hi Roman, yes, but it would be good to understand what is going wrong - the
debug info should help.  It would also be good to know the modem revision.
Serge, what revision do you see in /proc/bus/usb/devices?

All the best,

Duncan.
