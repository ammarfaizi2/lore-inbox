Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265797AbTL3Obx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 09:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265798AbTL3Obx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 09:31:53 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:49538
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S265797AbTL3Obw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 09:31:52 -0500
Date: Tue, 30 Dec 2003 09:41:57 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Best Low-cost IDE RAID Solution For 2.6.x? (OT?)
Message-ID: <20031230094157.A7191@animx.eu.org>
References: <20031228180424.GA16622@mail-infomine.ucr.edu> <3FEF8CFD.7060502@rackable.com> <20031229134150.GB30794@louise.pinerecords.com> <20031229185908.GB31215@mail-infomine.ucr.edu> <3FF07AD8.2040601@rackable.com> <20031229190327.B5729@animx.eu.org> <20031230065439.GA1517@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20031230065439.GA1517@louise.pinerecords.com>; from Tomas Szepe on Tue, Dec 30, 2003 at 07:54:39AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > nice about bad sectors as most hardware raid controllers.  On the other 
> > > hand the md driver kicks the ass of nearly every raid controller I've tried.
> > 
> > Faster than the mylex extreme raid 2000?  or one of the higher end adaptecs?
> 
> Even faster than HP/Compaq cciss hwraid setups, yes.

I've personally not had any experience with any hardware raid other than the
mylex DAC960 family.

One thing that keeps me from using the linux raid sw is the fact it can't be
partitioned.  I thought about lvm/evms, but I'm unwilling to make an initrd to
set it up (mounting root).  Unfortunately boot loaders don't seem to support
anything other than raid1. (Mostly lilo, but I'm not sure grub would do this
either)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
