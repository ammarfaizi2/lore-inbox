Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbTFDDun (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 23:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262771AbTFDDun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 23:50:43 -0400
Received: from ip68-111-188-90.sd.sd.cox.net ([68.111.188.90]:64222 "EHLO
	rei.moonkingdom.net") by vger.kernel.org with ESMTP id S262742AbTFDDum
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 23:50:42 -0400
Date: Tue, 3 Jun 2003 21:04:09 -0700
From: Marc Wilson <msw@cox.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Linux 2.4.21-rc6
Message-ID: <20030604040409.GA1670@moonkingdom.net>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <20030529052425.GA1566@moonkingdom.net> <BKEGKPICNAKILKJKMHCAIEANECAA.Riley@Williams.Name> <20030529055735.GB1566@moonkingdom.net> <Pine.LNX.4.55L.0306031302310.3892@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0306031302310.3892@freak.distro.conectiva>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03, 2003 at 01:02:45PM -0300, Marcelo Tosatti wrote:
> Ok, so you can reproduce the hangs reliably EVEN with -rc6, Marc?

Yes, with -rc6, and this:

rei $ dd if=/dev/zero of=/home/mwilson/largefile bs=16384 count=131072

The mouse starts skipping soon after the box starts swapping.  It
eventually catches up, but then when I start up another application, it
starts again.

I have the test running as I type this e-mail in mutt (with vim as the
editor), and there are noticeable pauses where I'm typing, but there isn't
anything happening on the screen.

It's *much* better than it was with my prior kernel (-rc2), but it's most
definately still there.

Anyone got any other test they want me to make on the box?

-- 
 Marc Wilson |     You're a card which will have to be dealt with.
 msw@cox.net |
