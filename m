Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbTLUNyf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 08:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbTLUNyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 08:54:35 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:31885 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S262901AbTLUNye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 08:54:34 -0500
Date: Sun, 21 Dec 2003 14:53:36 +0100
From: Kristian <kristian@korseby.net>
To: Octave <oles@ovh.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lot of VM problem with 2.4.23
Message-Id: <20031221145336.1c72d522.kristian@korseby.net>
In-Reply-To: <14ZDV-1H1-1@gated-at.bofh.it>
References: <14ZDV-1H1-1@gated-at.bofh.it>
X-Mailer: Sylpheed version 0.8.10claws13 (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Operating-System: i686 Linux 2.4.23-ck1
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Octave <oles@ovh.net> schrieb:
> Since we use 2.4.23 we have lot of crash. I have no kernel panic.
> All I can report is this kind of syslog's message:
> __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> VM: killing process rateup

That's the new aa VM. Andrea has removed the out_of_memory killer in 2.4.23. Search the archives, Marcelo has sent a patch to the list that re-enables the oom_killer.

*Kristian
