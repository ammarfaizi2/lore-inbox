Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271890AbTGRV77 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 17:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271888AbTGRV74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 17:59:56 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:56711 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S270391AbTGRV7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 17:59:04 -0400
Date: Sat, 19 Jul 2003 00:13:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org
Subject: Re: Software suspend testing in 2.6.0-test1
Message-ID: <20030718221347.GA4280@elf.ucw.cz>
References: <m2wueh2axz.fsf@telia.com> <20030717200039.GA227@elf.ucw.cz> <20030717130906.0717b30d.akpm@osdl.org> <m2d6g8cg06.fsf@telia.com> <20030718032433.4b6b9281.akpm@osdl.org> <20030718152205.GA407@elf.ucw.cz> <m2el0nvnhm.fsf@telia.com> <20030718094542.07b2685a.akpm@osdl.org> <m2oezrppxo.fsf@telia.com> <20030718131527.7cf4ca5e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030718131527.7cf4ca5e.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The patch below works, but doesn't really solve anything, because it
> > is just as slow as the original code.
> 
> That's OK - it's a step in the right direction.

Just beware: It is *not* okay (for production) to set kflushd as a
PF_IOTHREAD. Its okay for testing through.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
