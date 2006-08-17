Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWHQJcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWHQJcv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 05:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWHQJcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 05:32:51 -0400
Received: from [81.2.110.250] ([81.2.110.250]:55472 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S964778AbWHQJcu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 05:32:50 -0400
Subject: Re: Merging libata PATA support into the base kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: Lee Trager <Lee@PicturesInMotion.net>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Jason Lunz <lunz@falooley.org>, Jens Axboe <axboe@suse.de>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, Stefan Seyfried <seife@suse.de>
In-Reply-To: <20060817091842.GC17899@elf.ucw.cz>
References: <1155144599.5729.226.camel@localhost.localdomain>
	 <20060810122056.GP11829@suse.de> <20060810190222.GA12818@knob.reflex>
	 <200608102140.36733.rjw@sisk.pl> <44E3E1E6.9090908@PicturesInMotion.net>
	 <20060817091842.GC17899@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 17 Aug 2006 10:52:28 +0100
Message-Id: <1155808348.15195.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-17 am 11:18 +0200, ysgrifennodd Pavel Machek:
> > Well it seems I am one of those users who is bit by the resume bug. I
> > was wondering why no developer has replied to my
> > bug(http://bugzilla.kernel.org/show_bug.cgi?id=6840) even though many
> > users have. Id try to fix it myself but Ive never done kernel

Probably because its a repeat of a well known problem and nobody has
volunteered to fix it even when its been explained to them

When we set the HPA on boot we must do the same on resume or the error
you see occurs.

> 
> Time to learn?
> 
> 								Pavel
