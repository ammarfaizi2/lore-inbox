Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbVLIWjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbVLIWjT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 17:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbVLIWjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 17:39:19 -0500
Received: from tim.rpsys.net ([194.106.48.114]:21710 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932482AbVLIWjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 17:39:18 -0500
Subject: Re: spitz: Real time clock?
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20051209212850.GE4658@elf.ucw.cz>
References: <20051209212850.GE4658@elf.ucw.cz>
Content-Type: text/plain
Date: Fri, 09 Dec 2005 22:39:06 +0000
Message-Id: <1134167947.8092.116.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-09 at 22:28 +0100, Pavel Machek wrote:
> Is there driver for real time clock for spitz? I seem to get default
> time each time I boot. (And thats bad because means fsck "too much time
> since last check, check forced).

There is but its already included with the kernels you have. It doesn't
survive reboots and this is a limitation of the PXA processor. There's
not a lot we can do about it I'm afraid.

Richard

