Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbVBNVzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbVBNVzL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 16:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVBNVzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 16:55:11 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:20669 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261574AbVBNVzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 16:55:05 -0500
Subject: Re: PATCH: Address lots of pending pm_message_t changes
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>, Bernard Blackham <bernard@blackham.com.au>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050214134658.324076c9.akpm@osdl.org>
References: <1108359808.12611.37.camel@desktop.cunningham.myip.net.au>
	 <20050214213400.GF12235@elf.ucw.cz> <20050214134658.324076c9.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1108418226.12611.75.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 15 Feb 2005 08:57:07 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew et al.

On Tue, 2005-02-15 at 08:46, Andrew Morton wrote:
> Pavel Machek <pavel@suse.cz> wrote:
> >
> > Andrew, if you get one big patch doing only type-safety (u32 ->
> >  pm_message_t, no code changes), would you still take it this late? I
> >  promise it is not going to break anything... It would help merge after
> >  2.6.11 quite a lot...
> 
> Problem is, such a megapatch causes grief for all those people who maintain
> their own trees.  It would be best, please, to split it into 10-20 bits and
> send the USB parts to Greg and the SCSI bits to James, etc.

Okay; I can do that if everyone is happy with the thing as a whole.
Andrew, can I get your answer on Pavel's question - shall I just include
the u32->pm_message_t part?

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

