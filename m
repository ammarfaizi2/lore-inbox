Return-Path: <linux-kernel-owner+w=401wt.eu-S937573AbWLKTIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937573AbWLKTIG (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 14:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937566AbWLKTIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 14:08:06 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37487 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S937577AbWLKTID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 14:08:03 -0500
Date: Mon, 11 Dec 2006 19:15:43 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Corey Minyard <cminyard@mvista.com>, Tilman Schmidt <tilman@imap.cc>,
       linux-serial@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Hansjoerg Lipp <hjlipp@web.de>, Russell Doty <rdoty@redhat.com>
Subject: Re: [PATCH] Add the ability to layer another driver over the serial
 driver
Message-ID: <20061211191543.32ce2da8@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.60.0612111954120.4039@poirot.grange>
References: <4533B8FB.5080108@mvista.com>
	<20061210201438.tilman@imap.cc>
	<Pine.LNX.4.60.0612102117590.9993@poirot.grange>
	<457CB32A.2060804@mvista.com>
	<20061211102016.43e76da2@localhost.localdomain>
	<Pine.LNX.4.60.0612111954120.4039@poirot.grange>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> there as "protocols" for user-tty interfaces, i.e., you need a user, that 
> opens a tty, sets a line discipline to it, and does io (read/write) over 
> it, and NOT to be completely initialised and driven from the kernel.

Take a look at the SLIP driver. User space sets up the port but all the
actual I/O is to/from the kernel not via user space.
