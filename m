Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262455AbVBXTWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbVBXTWx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 14:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbVBXTWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 14:22:53 -0500
Received: from calma.pair.com ([209.68.1.95]:24076 "HELO calma.pair.com")
	by vger.kernel.org with SMTP id S262455AbVBXTWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 14:22:39 -0500
Date: Thu, 24 Feb 2005 14:22:37 -0500
From: "Chad N. Tindel" <chad@tindel.net>
To: Paulo Marques <pmarques@grupopie.com>
Cc: "Chad N. Tindel" <chad@tindel.net>, Chris Friesen <cfriesen@nortel.com>,
       Mike Galbraith <EFAULT@gmx.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Xterm Hangs - Possible scheduler defect?
Message-ID: <20050224192237.GA31894@calma.pair.com>
References: <20050224075756.GA18639@calma.pair.com> <30111.1109237503@www1.gmx.net> <20050224175331.GA18723@calma.pair.com> <421E1AC1.1020901@nortel.com> <20050224183851.GA24359@calma.pair.com> <421E2528.8060305@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421E2528.8060305@grupopie.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you keep a learning attitude, there is a chance for this discussion 
> to go on. However, if you keep the "Come now, don't bullshit me, this is 
> a broken architecture and you're just trying to cover up" attitude, 
> you're just going to get discarded as a troll.

I'm not trying to troll here; I suppose I'm just coming from a different 
background.  I'll try to adjust my tone.

> I personally like the linux way: "root has the ability to shoot himself 
> in the foot if he wants to". This is my computer, damn it, I am the one 
> who tells it what to do.

I'm all for allowing people to shoot themselves in the foot.  That doesn't
mean that it is OK for a single userspace thread to mess up a 64-way box.

> This is much, much better than the "users are stupid, we must protect 
> them from themselves" kind of way that other OS'es use.

Isn't this what the kernel attempts to do in many other places?  What else
could possibly be the point of sending SIGSEGV and causing applications
to dump core when they make a mistake referencing memory?  Isn't it the
kernel's job to protect one application from another? 

I see what you're saying about the swap daemon.  How about if I make my
statement less black and white.  Some kernel threads should always have 
priority over userspace.  

I believe the mindset required for a home system that is doing audio recordings
is different than the one for enterprise-level systems.  How do we unify
the two?

Chad
