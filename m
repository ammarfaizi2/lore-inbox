Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265415AbUBBOBx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 09:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265595AbUBBOBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 09:01:53 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:27654 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S265415AbUBBOBw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 09:01:52 -0500
To: "Miquel van Smoorenburg" <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: no console with current (bk) kernel
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <bvik4v$kf9$1@news.cistron.nl> (Miquel van Smoorenburg's
 message of "Sun, 1 Feb 2004 10:24:31 +0000 (UTC)")
References: <m3fzdvy0te.fsf@lugabout.jhcloos.org>
	<bvik4v$kf9$1@news.cistron.nl>
Date: Mon, 02 Feb 2004 09:01:06 -0500
Message-ID: <m3u12960nx.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Miquel" == Miquel van Smoorenburg <miquels@cistron.nl> writes:

>> and yet the boot fails with a complaint that it cannot open a
>> console, followed by a reboot.  (Too fast to copy anything down.)

>> What am I missing?

Miquel> A root filesystem ;)

Miquel> Looks like the kernel cannot open /dev/console.

That was it.  Box runs gentoo and is still using devfs; somehow
CONFIG_DEVFS_MOUNT got lost from my default config....

Thanks.

-JimC

