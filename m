Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbTHYMQo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 08:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbTHYMQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 08:16:44 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:10984 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261677AbTHYMQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 08:16:43 -0400
To: Andi Kleen <ak@colin2.muc.de>
Cc: Martin Pool <mbp@sourcefrog.net>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: KDB in the mainstream 2.4.x kernels?
References: <aJIn.3mj.15@gated-at.bofh.it>
	<m3smp3y38y.fsf@averell.firstfloor.org>
	<pan.2003.08.13.04.40.27.59654@sourcefrog.net>
	<20030813110453.GA26019@colin2.muc.de>
In-Reply-To: <20030813110453.GA26019@colin2.muc.de>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 25 Aug 2003 08:16:41 -0400
Message-ID: <87y8xiexue.fsf@stark.dyndns.tv>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi Kleen <ak@colin2.muc.de> writes:

> Only the X server can switch away, because only it knows how 
> to talk to the graphic chipset. And running user space here is 
> far too risky.

There was a proposal a long ways back to allow X to download instructions to
the kernel on how to restore the video mode. The proposal was to code the
instructions as a forth program that frobbed registers appropriately. The
kernel would have a small forth interpretor to run it. Then switching
resolutions could happen safely in the kernel.

-- 
greg

