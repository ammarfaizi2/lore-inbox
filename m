Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264929AbUGZGc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbUGZGc7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 02:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264931AbUGZGc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 02:32:59 -0400
Received: from host85.200-117-133.telecom.net.ar ([200.117.133.85]:57832 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S264929AbUGZGc6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 02:32:58 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: Future devfs plans (sorry for previous incomplete message)
Date: Mon, 26 Jul 2004 03:32:42 -0300
User-Agent: KMail/1.6.82
References: <200407261737.i6QHbff04878@freya.yggdrasil.com> <20040726062435.GA22559@thump.bur.st>
In-Reply-To: <20040726062435.GA22559@thump.bur.st>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407260332.43030.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trent Lloyd wrote:
> Wouldn't a possible solution to do this to develop an extension to tmpfs to
> catch files accessed that don't exist etc and use that in conjuction
> with udev?

Why would you want to do that? If the device node doesn't exist -> there's no 
hardware -> there's no need to load a driver/module.

udev/hotplug are doing the right thing (tm)

Regards,
Norberto
