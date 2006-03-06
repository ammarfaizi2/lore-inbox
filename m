Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752423AbWCFVzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423AbWCFVzs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752439AbWCFVzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:55:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9889 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752423AbWCFVzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:55:46 -0500
Date: Mon, 6 Mar 2006 16:55:15 -0500
From: Dave Jones <davej@redhat.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       Andrea Arcangeli <andrea@suse.de>, Mike Christie <michaelc@cs.wisc.edu>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
Message-ID: <20060306215515.GE11565@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jesper Juhl <jesper.juhl@gmail.com>, Jens Axboe <axboe@suse.de>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, markhe@nextd.demon.co.uk,
	Andrea Arcangeli <andrea@suse.de>,
	Mike Christie <michaelc@cs.wisc.edu>,
	James Bottomley <James.Bottomley@steeleye.com>
References: <200603060117.16484.jesper.juhl@gmail.com> <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org> <Pine.LNX.4.64.0603061147260.13139@g5.osdl.org> <200603062124.42223.jesper.juhl@gmail.com> <20060306203036.GQ4595@suse.de> <9a8748490603061341l50febef9o3cb480bdbdcf925f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490603061341l50febef9o3cb480bdbdcf925f@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 10:41:07PM +0100, Jesper Juhl wrote:

 > CONFIG_DEBUG_SLAB
 > CONFIG_PAGE_OWNER
 > CONFIG_DEBUG_VM
 > CONFIG_DEBUG_PAGEALLOC
 > 
 > The resulting kernel boots and runs just fine (no Oops) and leaves
 > nothing in dmesg.
 > So, without the debugging options it appears to the user that
 > everything is OK - nasty.

DEBUG_PAGEALLOC in particular is *fantastic* at making bugs hide.
I've lost many an hour trying to pin bugs down due to that.

		Dave


-- 
http://www.codemonkey.org.uk
