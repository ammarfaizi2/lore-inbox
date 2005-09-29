Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbVI2VfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbVI2VfD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 17:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbVI2VfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 17:35:03 -0400
Received: from drizzle.CC.McGill.CA ([132.206.27.48]:58349 "EHLO
	drizzle.cc.mcgill.ca") by vger.kernel.org with ESMTP
	id S1030242AbVI2VfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 17:35:00 -0400
Subject: Re: problem with 2.6.13.[0-2]
From: David Ronis <ronis@ronispc.chem.mcgill.ca>
Reply-To: David.Ronis@mcgill.ca
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: david.ronis@mcgill.ca, linux-kernel@vger.kernel.org
In-Reply-To: <58cb370e050929032935a87c72@mail.gmail.com>
References: <17206.60255.403692.773279@montroll.lan>
	 <58cb370e050929032935a87c72@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Department of Chemistry, McGill University
Date: Thu, 29 Sep 2005 17:34:24 -0400
Message-Id: <1128029664.15252.20.camel@montroll.chem.mcgill.ca>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reply.  lspci and lshw both show that it is not an
nvidia, rather the ATI chip.  The 5000 is a series, so perhaps they
changed things mid-stream.  My exact model is zv5240CA.

David

On Thu, 2005-09-29 at 12:29 +0200, Bartlomiej Zolnierkiewicz wrote:
> On 9/25/05, David Ronis <ronis@ronispc.chem.mcgill.ca> wrote:
> >
> > I recently tried upgrading from 2.6.12.6 to 2.6.13.[0-2] on an HP
> > pavilion zv5000 (a P4 with hyper-threading) running slackware-current.
> > The configuration and build went fine and the new kernel boots;
> > however, things run very very slowly.  As far as I can tell, what is
> > slow are process involving any disk IO.  For example, the part of the
> > boot where ldconfig is run seems to take 2-3 times as long as do
> > things like remaking the X font caches, loading programs etc.
> >
> > This vaguely reminds me of my initial experience with this laptop,
> > where I hadn't turned on CONFIG_BLK_DEV_ATIIXP, although it is now
> > (see below).  If I reboot with the old kernel, things run as before.
> 
> According to this page http://web.purplefrog.com/~thoth/zv5000/
> this laptop uses nForce3 chipset so you should turn on AMD/nForce
> IDE driver (CONFIG_BLK_DEV_AMD74XX).  Does it help?
> 
> Bartlomiej
> 
> 

