Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266645AbUBMCIo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 21:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266660AbUBMCIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 21:08:44 -0500
Received: from mail4-141.ewetel.de ([212.6.122.141]:968 "EHLO mail4.ewetel.de")
	by vger.kernel.org with ESMTP id S266645AbUBMCIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 21:08:43 -0500
To: "Nick Bartos" <spam99@2thebatcave.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: getting usb mass storage to finish before running init?
In-Reply-To: <1oAMR-6St-13@gated-at.bofh.it>
References: <1oAMR-6St-13@gated-at.bofh.it>
Date: Fri, 13 Feb 2004 03:09:45 +0100
Message-Id: <E1ArSm1-0003ei-Pv@localhost>
From: der.eremit@email.de
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Feb 2004 03:00:21 +0100, you wrote in linux.kernel:

> I can put a sleep in there but that is sloppy, and can not really be
> relied apon (since technically there is no way I can know how long the
> detection phase will take), and also I may be waisting time (which I don't
> want to, I want a fast booting router).

Check available devices for root filesystem (in case you're booting
from IDE). If it's not there, wait a moment, then look for additional
devices. If nothing shows up, repeat.

-- 
Ciao,
Pascal
