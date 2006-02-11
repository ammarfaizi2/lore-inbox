Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWBKVK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWBKVK7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 16:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWBKVK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 16:10:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64653 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932359AbWBKVK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 16:10:59 -0500
Date: Sat, 11 Feb 2006 13:10:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Doug McNaught <doug@mcnaught.org>
Cc: marc@osknowledge.org, mrmacman_g4@mac.com, adobriyan@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG GIT] Unable to handle kernel paging request at virtual
 address e1380288
Message-Id: <20060211131008.55f19bb6.akpm@osdl.org>
In-Reply-To: <87psltsy56.fsf@asmodeus.mcnaught.org>
References: <20060210214122.GA13881@stiffy.osknowledge.org>
	<20060210222515.GA4793@mipter.zuzino.mipt.ru>
	<20060210224238.GA5713@stiffy.osknowledge.org>
	<269F4ADB-FA82-47DD-9087-D07CA11DD681@mac.com>
	<20060211151005.GA5721@stiffy.osknowledge.org>
	<87y80hsz26.fsf@asmodeus.mcnaught.org>
	<20060211152930.GC5721@stiffy.osknowledge.org>
	<87psltsy56.fsf@asmodeus.mcnaught.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug McNaught <doug@mcnaught.org> wrote:
>
> Marc Koschewski <marc@osknowledge.org> writes:
> 
> > But the trace I sent didn't (directly) do any memory allocation so
> > the case was clear to me.
> >
> > From a developers point of view I totally agree that doing some bad
> > code 'here' might crash us 'there'. But the backtrace didn't look
> > like this to me...
> 
> You have no idea what might have happened a second ago, or a minute
> ago, or five minutes ago.  Corrupted memory is like a
> time-bomb--things don't always break right away.
> 

Probability this bug was caused by the nvidia module: 0.1%
Probability this bug was caused by USB or SCSI: 99.9%

SCSI and USB device management remain quite buggy and we need all the help
we can get in finding and fixing these problems.
