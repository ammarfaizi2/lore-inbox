Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbVCRS3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVCRS3U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 13:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbVCRS3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 13:29:20 -0500
Received: from pop-6.dnv.wideopenwest.com ([64.233.207.24]:6039 "EHLO
	pop-6.dnv.wideopenwest.com") by vger.kernel.org with ESMTP
	id S262008AbVCRS15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 13:27:57 -0500
Date: Fri, 18 Mar 2005 13:27:54 -0500
From: Paul <set@pobox.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Repeatable IDE Oops for 2.6.11 (ide-scsi vs ide-cdrom)
Message-ID: <20050318182754.GC7974@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <20050314065508.GA7974@squish.home.loc> <58cb370e05031808341bbe5622@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e05031808341bbe5622@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, on Fri Mar 18, 2005 [05:34:06 PM] said:
> On Mon, 14 Mar 2005 01:55:08 -0500, Paul <set@pobox.com> wrote:
> >         Hi;
> > 
> >         Here is what I did:
> > 
> > # modprobe ide-scsi
> > # cd /proc/ide/hdd      (this is a dvdrw drive)
> > # cat driver
> > > ide-cdrom version 4.61
> > # echo ide-scsi > driver
> > # cat driver
> > > ide-scsi (something--- didnt note exactly, except it was ide-scsi)
> > # echo ide-cdrom > driver
> > 
> > The shell is killed and Oops.
> > 
> > Machine flakey and half alive at this point. Reboot with Alt-sysrq.
> > The same thing works with 2.6.10, without Oops.
> 
> Please see http://lkml.org/lkml/2005/2/11/132

	Hi;

	What is the nature of the 'ide-dev-2.6 tree'? Are there broken
out patches available I can test vs. 2.6.11 or -mm? How do the 'ide fixes'
in -ac intersect with ide-dev? I am also curious if these patches could
have any effect on the pktcdvd problems I have reported.[*]
	Thanks for the feedback.

Paul
set@pobox.com

* http://lists.suse.com/archive/packet-writing/2005-Mar/0001.html
