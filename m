Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422735AbWGJRx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422735AbWGJRx2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 13:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422734AbWGJRx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 13:53:28 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:43488 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1422720AbWGJRx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 13:53:27 -0400
Message-ID: <44B2940A.2080102@pobox.com>
Date: Mon, 10 Jul 2006 13:53:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: yi.zhu@intel.com, jketreno@linux.intel.com,
       Netdev list <netdev@vger.kernel.org>, linville@tuxdriver.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] do not allow IPW_2100=Y or IPW_2200=Y
References: <20060710152032.GA8540@elf.ucw.cz>
In-Reply-To: <20060710152032.GA8540@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Kconfig currently allows compiling IPW_2100 and IPW_2200 into kernel
> (not as a module). Unfortunately, such configuration does not work,
> because these drivers need a firmware, and it can't be loaded by
> userspace loader when userspace is not running.

False, initramfs...


