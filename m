Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263902AbTKJPTX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 10:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263912AbTKJPTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 10:19:23 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:36519 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263902AbTKJPTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 10:19:22 -0500
Subject: Re: OT: why no file copy() libc/syscall ??
From: David Woodhouse <dwmw2@infradead.org>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: "Ihar 'Philips' Filipau" <filia@softhome.net>,
       Davide Rossetti <davide.rossetti@roma1.infn.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <03111007291500.08768@tabby>
References: <QiyV.1k3.15@gated-at.bofh.it> <3FAF7FC8.8050503@softhome.net>
	 <03111007291500.08768@tabby>
Content-Type: text/plain
Message-Id: <1068477550.5743.50.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.1) 
Date: Mon, 10 Nov 2003 15:19:11 +0000
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: dwmw2@infradead.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-10 at 07:29 -0600, Jesse Pollard wrote:

> > > sys_fscopy(...)
> 
> It is too simple to implement in user mode.

Is it? Please explain the simple steps which cp(1) should take in order
to observe that it is being asked to duplicate a file on a file system
such as CIFS (or NFSv4?) which allows the client to issue a 'copy file'
command over the network without actually transferring the data twice,
and to invoke such a command.

-- 
dwmw2

