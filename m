Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264781AbUEKPFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264781AbUEKPFX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 11:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264782AbUEKPFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 11:05:23 -0400
Received: from zork.zork.net ([64.81.246.102]:16822 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S264781AbUEKPFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 11:05:18 -0400
To: Thiago Robert <robert@inf.ufsc.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Write-combining
References: <40A0E808.2020602@inf.ufsc.br>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Thiago Robert <robert@inf.ufsc.br>,
 linux-kernel@vger.kernel.org
Date: Tue, 11 May 2004 16:05:16 +0100
In-Reply-To: <40A0E808.2020602@inf.ufsc.br> (Thiago Robert's message of
 "Tue, 11 May 2004 11:49:44 -0300")
Message-ID: <6uk6zjypg3.fsf@zork.zork.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thiago Robert <robert@inf.ufsc.br> writes:

> Is the default behaviour of the Linux kernel to enable
> write-combining? How can I be sure if it is enabled or not?

My /proc/mtrr lists the following region:

reg03: base=0xf8000000 (3968MB), size=  64MB: write-combining, count=2

which I am guessing is the PCI space, although I'm not certain.
