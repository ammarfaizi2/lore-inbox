Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbUFWVsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUFWVsv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 17:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUFWVs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 17:48:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46720 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263126AbUFWVpp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:45:45 -0400
Message-ID: <40D9F9F4.8030502@pobox.com>
Date: Wed, 23 Jun 2004 17:45:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeremy Katz <jeremy.katz@gmail.com>, Greg KH <greg@kroah.com>
CC: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@osdl.org>,
       Linus <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       katzj@redhat.com
Subject: Re: [PATCH] PPC64 iSeries viodasd proc file
References: <20040618165436.193d5d35.sfr@canb.auug.org.au> <40D305B4.4030009@pobox.com> <20040618151753.GA21596@infradead.org> <cb5afee1040620125272ab9f06@mail.gmail.com> <20040621060435.GA28384@kroah.com> <cb5afee10406210914451dc6@mail.gmail.com> <cb5afee10406231415293e90c0@mail.gmail.com>
In-Reply-To: <cb5afee10406231415293e90c0@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Katz wrote:
> And to be more constructive (after a discussion with Jeff this
> afternoon which is when I realized the reply didn't go out), what
> would be _very_ useful to have from a "probing disks" perspective
> would be a way to enumerate easily and simply from within sysfs the
> disks that are associated with a specific controller.  Not entirely
> sure where under sysfs this would go, but to be able to easily see
> that for block device type foo, I have disks disk0, disk1 and disk2. 
> The vio sysfs stuff actually works kind of nicely like this, but it
> would be more useful as a generic thing rather than not being able to
> depend on it.

And here's what I said to Jeremy over IRC as well...

I think it's perfectly reasonable to want a "driver -> registered 
devices" mapping.  That's what the installer appears to want, if I 
understand Jeremy correctly.

That will probably take some thought by the sysfs wizards, though, since 
drivers are registered on a per-bus basis...

	Jeff


