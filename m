Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbTIZSYb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 14:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbTIZSYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 14:24:31 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:34052 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S261484AbTIZSYa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 14:24:30 -0400
From: Michael Frank <mhf@linuxmail.org>
To: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns?=
	=?iso-8859-1?q?=20Rullg=E5rd?=),
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [BUG?] SIS IDE DMA errors
Date: Sat, 27 Sep 2003 02:15:27 +0800
User-Agent: KMail/1.5.2
Cc: andre@linux-ide.org, linux-kernel@vger.kernel.org
References: <yw1x7k3vlokf.fsf@users.sourceforge.net> <20030926165957.GA11150@ucw.cz> <yw1x7k3vjw8o.fsf@users.sourceforge.net>
In-Reply-To: <yw1x7k3vjw8o.fsf@users.sourceforge.net>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200309270215.27886.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 September 2003 01:27, Måns Rullgård wrote:
> Vojtech Pavlik <vojtech@suse.cz> writes:
> 
> > Actually, it's me who wrote the 961 and 963 support. It works fine for
> > most people. Did you check you cabling?
> 
> I'm dealing with a laptop, but I suppose I could wiggle the cables a
> bit.  I still doubt it's a cable problem, since reading works
> flawlessly.

And the cables are nicely short...

> 
> It appears to me that during heavy IO load, some DMA interrupts get
> lost, for some reason.

Could you cat /proc/interrupts to see if the IDE interrupt is shared 
by chance?

Regards
Michael


