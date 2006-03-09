Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbWCIQmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbWCIQmT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 11:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWCIQmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 11:42:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50086 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751329AbWCIQmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 11:42:18 -0500
Date: Thu, 9 Mar 2006 11:41:51 -0500
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, Jesper Juhl <jesper.juhl@gmail.com>,
       Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       Andrea Arcangeli <andrea@suse.de>, Mike Christie <michaelc@cs.wisc.edu>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
Message-ID: <20060309164151.GB30809@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	"Martin J. Bligh" <mbligh@mbligh.org>,
	Jesper Juhl <jesper.juhl@gmail.com>, Jens Axboe <axboe@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, markhe@nextd.demon.co.uk,
	Andrea Arcangeli <andrea@suse.de>,
	Mike Christie <michaelc@cs.wisc.edu>,
	James Bottomley <James.Bottomley@steeleye.com>
References: <200603060117.16484.jesper.juhl@gmail.com> <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org> <Pine.LNX.4.64.0603061147260.13139@g5.osdl.org> <200603062124.42223.jesper.juhl@gmail.com> <20060306203036.GQ4595@suse.de> <9a8748490603061341l50febef9o3cb480bdbdcf925f@mail.gmail.com> <20060306215515.GE11565@redhat.com> <44104EB7.9090103@mbligh.org> <Pine.LNX.4.64.0603090802350.18022@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603090802350.18022@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 08:08:52AM -0800, Linus Torvalds wrote:

 > IOW, DEBUG_SLAB is something that a distro kernel can reasonably enable 
 > for users by default (I think fedora-devel does, for example).

Correct.

 > - neither: usable for benchmarking
 > - DEBUG_SLAB: perfectly usable for normal work
 > - DEBUG_PAGEALLOC (with or without DEBUG_SLAB): debugging tool only
 >
 > At least that's my opinion, maybe others have other experiences.

That's pretty much my experience.  I get people screaming at me when
I enable PAGEALLOC for a day or so in the Fedora-devel kernel if I'm
chasing something :)

		Dave

-- 
http://www.codemonkey.org.uk
