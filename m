Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUI1KVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUI1KVp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 06:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbUI1KVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 06:21:45 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:41159 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S265029AbUI1KVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 06:21:44 -0400
Message-ID: <81b0412b0409280321235178f1@mail.gmail.com>
Date: Tue, 28 Sep 2004 12:21:44 +0200
From: Alex Riesen <raa.lkml@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
To: Aboo Valappil <aboo@aboosplanet.com>
Subject: Re: Switch back to Real mode and then boot strap
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <NAYASmLAztxc1o8yfog00000008@naya.ABOOSPLANET.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41592C64.3030409@yahoo.com.au>
	 <NAYASmLAztxc1o8yfog00000008@naya.ABOOSPLANET.COM>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2004 20:11:59 +1000, Aboo Valappil <aboo@aboosplanet.com> wrote:
> Basically I have a requirement of re-booting ( Without really rebooting )
> the OS from the hard disk ( even if a floppy is present or a bootable CD-ROM
> is present).  Update CMOS to change the boot sequence is not an option for
> my requirement.

You probably want to look at kexec.
I.e. there: http://lwn.net/Articles/15468/
