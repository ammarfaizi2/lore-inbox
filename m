Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752261AbVHGQTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261AbVHGQTG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 12:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752262AbVHGQTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 12:19:06 -0400
Received: from mx1.suse.de ([195.135.220.2]:20156 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752260AbVHGQTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 12:19:05 -0400
Date: Sun, 7 Aug 2005 18:19:02 +0200
From: Andi Kleen <ak@suse.de>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Andi Kleen <ak@suse.de>, Erick Turnquist <jhujhiti@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Lost Ticks on x86_64
Message-ID: <20050807161902.GX8266@wotan.suse.de>
References: <080720051429.26355.42F61ABC0005F4BA000066F3220699849900009A9B9CD3040A029D0A05@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <080720051429.26355.42F61ABC0005F4BA000066F3220699849900009A9B9CD3040A029D0A05@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 07, 2005 at 02:29:16PM +0000, Parag Warudkar wrote:
> > No way to fix this, but you can work around it with very new kernels
> > by compiling with a lower HZ than 1000.
> 
> John Stultz's timeofday patches seem to fix this lost ticks issue.  You might want to try them.
> 
> (I too, routinely get "lost ticks - rip is at acpi_processor_idle" messages which vanished during the period when I was trying John's patches.)

They will just hide the problem in this case.

-Andi
