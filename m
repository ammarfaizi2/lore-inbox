Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263944AbTEOKIu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 06:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263945AbTEOKIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 06:08:50 -0400
Received: from port-212-202-172-137.reverse.qdsl-home.de ([212.202.172.137]:59805
	"EHLO jackson.localnet") by vger.kernel.org with ESMTP
	id S263944AbTEOKIt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 06:08:49 -0400
Date: Thu, 15 May 2003 12:25:00 +0200 (CEST)
Message-Id: <20030515.122500.35026542.rene.rebe@gmx.net>
To: josh@toad.stack.nl
Cc: mikpe@csd.uu.se, linux-kernel@vger.kernel.org
Subject: Re: APIC error
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <20030515120614.R94113@toad.stack.nl>
References: <20030514.221858.846957347.rene.rebe@gmx.net>
	<16067.22472.306565.803037@gargle.gargle.HOWL>
	<20030515120614.R94113@toad.stack.nl>
X-Mailer: Mew version 3.1 on XEmacs 21.4.12 (Portable Code)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On: Thu, 15 May 2003 12:09:38 +0200 (CEST),
    Jos Hulzink <josh@toad.stack.nl> wrote:
> > No load balancing of I/O interrupts since they will all be directed to
> > CPU 0 only. Unless your dual P5 is servicing a lot of interrupts, I doubt
> > it will make a noticeable difference.
> 
> On my Dual PII 333, KDE 3.1 runs fine with interrupts mapped to both CPUs,
> and performance is horrible when only CPU0 receives the interrupts.
> 
> Especially moving the timer interrupt to both CPUs makes difference like
> night and day.

Thanks for all your contributions ;-) But with noapic I also get APIC
errors from time to time (altough /etc/intrerrupts shows that the
XT-PIC is used). But anyway the box is not running very reliable in
both modes and processes seg-fault every now and then and sometimes
the box freezed. I'll get rid of the box I got for free and no longer
waste our time ... ;-)

> Jos

Sincerely,
  René Rebe

--  
René Rebe - Europe/Germany/Berlin
  rene@rocklinux.org rene.rebe@gmx.net
http://www.rocklinux.org http://www.rocklinux.org/people/rene       
http://gsmp.tfh-berlin.de/gsmp http://gsmp.tfh-berlin.de/rene
