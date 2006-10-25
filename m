Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWJ1Ewq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWJ1Ewq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 00:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbWJ1Ewq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 00:52:46 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5645 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S1750890AbWJ1Ewp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 00:52:45 -0400
Date: Wed, 25 Oct 2006 16:42:27 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Hellwig <hch@infradead.org>, Avi Kivity <avi@qumranet.com>,
       Arnd Bergmann <arnd@arndb.de>, Muli Ben-Yehuda <muli@il.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Anthony Liguori <aliguori@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
Message-ID: <20061025164227.GA5675@ucw.cz>
References: <4537818D.4060204@qumranet.com> <200610221723.48646.arnd@arndb.de> <453B99D7.1050004@qumranet.com> <200610221851.06530.arnd@arndb.de> <453BA3E9.4050907@qumranet.com> <20061022175609.GA28152@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061022175609.GA28152@infradead.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >What is the point of 32 bit hosts anyway? Isn't this only available
> > >on x86_64 type CPUs in the first place?
> > >  
> > 
> > No, 32-bit hosts are fully supported (except a 32-bit host can't run a 
> > 32-bit guest).
> 
> Again, what's the point?  All cpus shipped by Intel and AMD that have
> hardware virtualization extensions also support the 64bit mode.  Given
> that I don't see any point for supporting a 32bit host.

If you have 1GB ram, having 64-bit capable cpu does not mean you want
to run 64-bit kernel. Pointers are twice as big, etc... And if your
shiny new cpu fails, you can't put hdd back in good old working
machine.

(IOW I see reasons. Not sure if they are big enough...)
							Pavel
-- 
Thanks for all the (sleeping) penguins.
