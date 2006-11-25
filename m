Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933958AbWKYXDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933958AbWKYXDD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 18:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934218AbWKYXDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 18:03:03 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:31975 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S933958AbWKYXDA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 18:03:00 -0500
Date: Sat, 25 Nov 2006 23:08:26 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: linux-kernel@vger.kernel.org,
       Linux ARM Kernel list 
	<linux-arm-kernel@lists.arm.linux.org.uk>,
       kernel-discuss@handhelds.org
Subject: Re: tty line discipline driver advice sought, to do a 1-byte header
 and 2-byte CRC checksum on GSM data
Message-ID: <20061125230826.22d69a35@localhost.localdomain>
In-Reply-To: <20061125040614.GI16214@lkcl.net>
References: <20061125040614.GI16214@lkcl.net>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> userspace, which would be a hell of a lot easier, but would make
> applications a pain, because they would need to use a library instead of
> just opening /dev/ttySN just like any other phone app, to transfer AT
> commands.

Like gnokii for example ?

You can do both - use a pty/tty pair to front the daemon
