Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbVG0IA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbVG0IA6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 04:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbVG0IA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 04:00:57 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9408 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262062AbVG0IA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 04:00:56 -0400
Date: Wed, 27 Jul 2005 10:00:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: Marc Ballarin <Ballarin.Marc@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ250 vs. HZ1000
Message-ID: <20050727080051.GF4115@elf.ucw.cz>
References: <20050725161333.446fe265.Ballarin.Marc@gmx.de> <20050725155322.GA1046@openzaurus.ucw.cz> <20050727075156.GC25827@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050727075156.GC25827@atomide.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > USB devices prevent entering C3 and any interesting powersaving,
> > try without USB...
> 
> Why do USB devices prevent C3? If it was because of the timer polling
> in the root hub, I believe that should be fixed now.
> 
> Or is there some other reason?

Yes. UHCI zas keeps doing DMA all the time.... It can be worked
around, but it means proper usb powermanagment support.
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
