Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbWBUM7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWBUM7e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 07:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWBUM7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 07:59:34 -0500
Received: from main.gmane.org ([80.91.229.2]:11684 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751084AbWBUM7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 07:59:33 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Happe <andreashappe@snikt.net>
Subject: Re: Which is simpler? (Was Re: Re: [ 00/10] [Suspend2] Modules support.)
Followup-To: gmane.linux.kernel
Date: Tue, 21 Feb 2006 12:59:06 +0000 (UTC)
Message-ID: <slrndvm3kp.rev.andreashappe@localhost.localdomain>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060220173608.GC33155@dspnet.fr.eu.org> <slrndvkp1m.326.andreashappe@localhost.localdomain> <200602211257.29161.ncunningham@cyclades.com>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: chello062178006202.3.11.tuwien.teleweb.at
User-Agent: slrn/0.9.8.1pl1 (Debian)
Cc: suspend2-devel@lists.suspend2.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-02-21, Nigel Cunningham <ncunningham@cyclades.com> wrote:
> On Tuesday 21 February 2006 10:52, Andreas Happe wrote:
>
>> I tried to use suspend2, but setup wasn't that great (i.e. didn't
>> work as well or easy as swsusp) so I dropped it.
>
> Could you provide more detail? If there's something I can do to make
> it eas= ier=20 to use, I'm more than willing to consider that.

it's way too long ago to remember specifics, the system didn't resume
after suspending. Swsusp worked just out of the box (sans dri support
after resuming) without the need to apply a patch (which wasn't supplied
as normal patch (if i remember correctly) but was used by starting a
script)). I'm sorry that I didn't submit a proper bug report, but the
alternative worked for me.

You can't make it simpler except you get in included into mainline (even
by making compromises).

> 12 bytes per page is 3MB/1GB. If swsusp was to add support for
> multiple swap partitions or writing to files, those requirement 20
> might be closer to 5MB/GB. Bitmaps, in comparison, use ~32K/GB (approx
> because it depends whether the gigabyte is all in one zone).
> Proportionally ,20 bitmaps are eating a lot less space out of your
> gigabyte, but I don't think anyone is going to notice that they have 3
> or 4MB more cache per gigabyte with Suspend2 than they have with
> swsusp).

This would take suspend2 a step closer to mainline.. you'll have a very
honest 'Thank You' if that could happen..

andy

