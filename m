Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbVIMIPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbVIMIPJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 04:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbVIMIPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 04:15:09 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:39816 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932438AbVIMIPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 04:15:08 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Greg KH <gregkh@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
       "Gaston, Jason D" <jason.d.gaston@intel.com>, mj@ucw.cz, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13-rc4 1/1] pci_ids: patch for Intel ICH7R
Date: Tue, 13 Sep 2005 18:14:46 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <n22di195igbdp9mc1vg9vq6056fsc7a7cl@4ax.com>
References: <26CEE2C804D7BE47BC4686CDE863D0F5046EA44B@orsmsx410> <42EAABD1.8050903@pobox.com> <n4ple1haga8eano2vt2ipl17mrrmmi36jr@4ax.com> <42EAF987.7020607@pobox.com> <6f0me1p2q3g9ralg4a2k2mcra21lhpg6ij@4ax.com> <20050911031150.GA20536@kroah.com> <pfn7i1ll7g5bs8sm8kq0md33f8khsujrbf@4ax.com> <4323EFFE.2040102@pobox.com> <kctci1lqlgbr9ct7as48j551o6v9013504@4ax.com> <20050913070324.GA7968@suse.de>
In-Reply-To: <20050913070324.GA7968@suse.de>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2005 00:03:24 -0700, Greg KH <gregkh@suse.de> wrote:

>On Tue, Sep 13, 2005 at 04:46:45PM +1000, Grant wrote:
>> On Sun, 11 Sep 2005 04:51:10 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
>> >
>> >pci_ids.h should be the place where PCI IDs (class, vendor, device) are 
>> >collected.
>> 
>> Few files reference it.
>
>include/pci.h does, so pretty much every pci driver does because of
>that.

That's probably the little aspect I missed :)  Something wasn't making 
sense to me.
>
>> >Long term, we should be able to trim a lot of device ids, since they are 
>> >usually only used in one place.
>> 
>> Well, they're not, and trimming a file marked for removal is pointless.
>
>Huh?  That file isn't marked for removal, that was the id database,
>which is now gone...

Ahh, that explains my confusion, I'll have another look at it.

Grant.

