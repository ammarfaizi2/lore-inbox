Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbWISICH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWISICH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 04:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWISICG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 04:02:06 -0400
Received: from mail.suse.de ([195.135.220.2]:42469 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751301AbWISICE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 04:02:04 -0400
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: billm@melbpc.org.au, billm@suburbia.net,
       "Linus Torvalds" <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Math-emu kills the kernel on Athlon64 X2
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com>
From: Andi Kleen <ak@suse.de>
Date: 19 Sep 2006 10:01:55 +0200
In-Reply-To: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com>
Message-ID: <p73venk2sjw.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jesper Juhl" <jesper.juhl@gmail.com> writes:

> Hi,
> 
> If I enable the math emulator in 2.6.18-rc7-git2 (only version I've
> tried this with) and then boot the kernel with "no387" then I only get
> as far as lilo's "...Booting the kernel." message and then the system
> hangs.
> 
> The kernel is a 32bit kernel build for K8 and my CPU is a Athlon64 X2 4400+

Do you have a .config? I tried it and it booted until mounting root.

-Andi
