Return-Path: <linux-kernel-owner+w=401wt.eu-S965241AbXATKVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965241AbXATKVV (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 05:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965242AbXATKVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 05:21:21 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:40902 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965241AbXATKVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 05:21:21 -0500
Message-ID: <45B1ED19.30000@drzeus.cx>
Date: Sat, 20 Jan 2007 11:21:13 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To: Alex Dubov <oakad@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: mmc: correct semantics of the mmc_host_remove
References: <859705.85986.qm@web36713.mail.mud.yahoo.com>
In-Reply-To: <859705.85986.qm@web36713.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Dubov wrote:
>
> Indeed, I may be out of sync on this. Simply, I have this rather ugly hack in the tifm_sd remove
> code which I was forced to add because of the issue in question.
> I'll do some tests with newer kernels then.
>
>   

Please do. And if you see a problem, please try to figure out who it is
accessing the device.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

