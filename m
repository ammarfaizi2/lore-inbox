Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262576AbUKQW2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262576AbUKQW2N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 17:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbUKQWZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 17:25:40 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:39507 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262640AbUKQWU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 17:20:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=WnyQUgA9ShLWxVBBBH2fwR0/K2bXd3Gj5HtJgacPYgDbmS4Vxk5UBExXlp+Y/pksAjh26Vw+hNWiZyzOiIhE4YOwwr5g4eBHk3n3pdOESmJ0SVftISg5DgpEMggC1jPf/sKDr80gcfh98LuoPG8XaV76Ds9GP+2HGiZ3rXDd9h4=
Message-ID: <58cb370e041117142010059323@mail.gmail.com>
Date: Wed, 17 Nov 2004 23:20:29 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: Re: [BUG] Kernel disables DMA on RICOH CD-R/RW
Cc: Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
In-Reply-To: <200411180916.27342.sriharivijayaraghavan@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041116124656.82075.qmail@web52601.mail.yahoo.com>
	 <1100706838.420.47.camel@localhost.localdomain>
	 <20041117210657.GP26240@suse.de>
	 <200411180916.27342.sriharivijayaraghavan@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004 09:16:27 +1100, Srihari Vijayaraghavan
<sriharivijayaraghavan@yahoo.com.au> wrote:
> On Thu, 18 Nov 2004 08:06 am, Jens Axboe wrote:
> 
> 
> > On Wed, Nov 17 2004, Alan Cox wrote:
> > > On Maw, 2004-11-16 at 13:01, Bartlomiej Zolnierkiewicz wrote:
> > > > Previously VIA IDE driver ignored DMA blacklists completely
> > > > (which was of course wrong), it was fixed.
> > > >
> > > > Probably this drive should be removed from the blacklist.
> > > > Does anybody remember why was it added there?
> > >
> > > As I said before almost all of our blacklist is junk from when the IDE
> > > ATAPI DMA bug wasn't fixed.
> >
> > I sure don't remember why, so sounds plausible.
> 
> Could you please accept this patch? (against vanilla 2.6.10-rc2)
> 
> I have tested my RICOH CD-R/RW with this patch (on CD Reading/Writing), and it
> works just fine with DMA enabled.
> 
> (Unfortunately I do not have any other drive in the DMA disabled list, and
> hence I could not test for them.)

applied
