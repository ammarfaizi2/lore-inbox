Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264054AbUDBOWW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 09:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264052AbUDBOWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 09:22:21 -0500
Received: from host199.200-117-131.telecom.net.ar ([200.117.131.199]:37029
	"EHLO smtp.bensa.ar") by vger.kernel.org with ESMTP id S264054AbUDBOVt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 09:21:49 -0500
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: tehdely_lkml@metawire.org
Subject: Re: mm-kernels, 4K stacks, and NVIDIA... am I crazy?
Date: Fri, 2 Apr 2004 11:21:46 -0300
User-Agent: KMail/1.6.2
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <d61dc3fbcc9848976bdd9c3890c55940@localhost.localdomain>
In-Reply-To: <d61dc3fbcc9848976bdd9c3890c55940@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404021121.46697.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Baehr wrote:
> 06:55:05 <+delysid|~> grep 4K /usr/src/linux/.config
> CONFIG_4KSTACKS=y
> 06:55:08 <+delysid|~>
>
> And I have yet to have a single problem.  In fact, everything is
> working swimmingly!

Are you sure you are using nvidia's binary driver?

$ dmesg | grep nvidia
$ grep -i nvidia /var/log/XF*

Regards,
Norberto

PS: I'm recompiling my kernel with 4KSTACKS, but I doubt it will work.
