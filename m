Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424227AbWKIXPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424227AbWKIXPw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 18:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424249AbWKIXPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 18:15:51 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35047 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1424227AbWKIXPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 18:15:51 -0500
Date: Fri, 10 Nov 2006 00:15:33 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Michael Holzheu <holzheu@de.ibm.com>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       mschwid2@de.ibm.com
Subject: Re: How to document dimension units for virtual files?
Message-ID: <20061109231533.GE2616@elf.ucw.cz>
References: <20061108175412.3c2be30c.holzheu@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061108175412.3c2be30c.holzheu@de.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> What about the following ...

Looks good to me.

> +> ls /sys/kernel/debug/sysinfo
> +free_mem_KiB
> +online_time_ms
> +cpu_time_us
> +
> +> cat /sys/kernel/debug/free_mem_KiB
> +147536

Someone had idea of free_mem:KiB ... which is quite neat.

Anyway, Greg's opinion was that we should just document units in
documentation and not pollute names with that. I'm not sure if it
works for battery (because of current:mA vs. current:mW confusion).

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
