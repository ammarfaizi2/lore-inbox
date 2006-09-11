Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWIKWe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWIKWe6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 18:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWIKWe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 18:34:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7145 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932175AbWIKWe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 18:34:57 -0400
Date: Mon, 11 Sep 2006 15:31:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, linux-scsi@vgter.kernel.org
Subject: Re: [PATCH 1/2] cciss: version update, new hw
Message-Id: <20060911153140.3f2433a9.akpm@osdl.org>
In-Reply-To: <20060911213126.GA6867@beardog.cca.cpqcorp.net>
References: <20060911213126.GA6867@beardog.cca.cpqcorp.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2006 16:31:26 -0500
"Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net> wrote:

> This patch adds support for new hardware and bumps the version to 3.6.10. It
> seems there were several changes introduced including soft_irq. I decided
> to bump the major number to reflect these changes. Since we're still 
> supporting older vendor kernels I need some way differenciate between kernel
> versions <=2.6.10 and newer kernels >=2.6.16. 
> I hate to send this in -rc6 but it seems like 2.6.18 is having a tough time
> getting out the gate. Please consider this for inclusion.

Adding a new device ID is a bit of a no-brainer - in fact bumping the
version number seems more risky than adding a device ID.

I'd be OK with a 2.6.18 merge, and shall send it into Linus unless Jens
nacks it, or gets there first.

