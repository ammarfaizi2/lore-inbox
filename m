Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751699AbWBQXqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbWBQXqa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 18:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbWBQXqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 18:46:30 -0500
Received: from smtp.enter.net ([216.193.128.24]:51719 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1751488AbWBQXq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 18:46:29 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Fri, 17 Feb 2006 18:46:38 -0500
User-Agent: KMail/1.8.1
Cc: jengelh@linux01.gwdg.de, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org
References: <43EB7BBA.nailIFG412CGY@burner> <Pine.LNX.4.61.0602171643560.27452@yvahk01.tjqt.qr> <43F64588.nail3BO1TI7E1@burner>
In-Reply-To: <43F64588.nail3BO1TI7E1@burner>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602171846.39363.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 February 2006 16:52, Joerg Schilling wrote:
> Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> > >Sorry, the way to access SCSI generic via /dev/hd* is deprecated. If
> > > ide-scsi ir removed, then a clean and orthogonal way of accessing SCSI
> > > in a generic way is removed from Linux. If Linux does nto care about
> > > orthogonality of interfaces, this is a problem of the people who are
> > > responbile for the related interfaces.
> >
> > So what you want is to be able to use write() on a <sg-compatible> device
> > rather than doing SG_IO ioctl() on <any> device?
>
> This kind of disinformation is what constantly puts fuel into the fire....
>
> Are you a victim of the firebugs in this list?

Joerg, it may not be perfect, but it does work. If you're still worried about 
how a few of the currently unmaintained devices still don't support SG_IO 
then I suggest you find someone to take maintainership.

I have neither the skill nor the want to do it or I would, just to see if it 
quieted you down any.

BTW, make it more than a couple of weeks for the patch I mentioned for libscg 
- I still need a response about my suggestion to use the BTL addresses Linux 
provides as the addresses passed around from libscg to cdrecord.

DRH
