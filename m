Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275003AbTHFLJt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 07:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275004AbTHFLJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 07:09:48 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:40886 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S275003AbTHFLJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 07:09:09 -0400
Date: Wed, 6 Aug 2003 13:08:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Adrian Bunk <bunk@fs.tum.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: TSCs are a no-no on i386
Message-ID: <20030806110855.GA583@elf.ucw.cz>
References: <20030730135623.GA1873@lug-owl.de> <20030730181006.GB21734@fs.tum.de> <20030730183033.GA970@matchmail.com> <20030730184529.GE21734@fs.tum.de> <1059595260.10447.6.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059595260.10447.6.camel@dhcp22.swansea.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >   Note that this can also allow Step-A 486's to correctly run multi-thread
> >   applications since cmpxchg has a wrong opcode on this early CPU.
> > 
> >   Don't use this to enable multi-threading on an SMP machine, the lock
> >   atomicity can't be guaranted!
> 
> That is of course the other problem with this approach - you can't
> really get the intended results without some extremely heavyweight code
> (using an IPI to halt all CPU's, doing the access and then resuming
> them)

Hopefully there are not too many SMP-486 machines out there ;-).
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
