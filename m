Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135773AbREBSzK>; Wed, 2 May 2001 14:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135725AbREBSyz>; Wed, 2 May 2001 14:54:55 -0400
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:9358 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S135760AbREBSyK>; Wed, 2 May 2001 14:54:10 -0400
Date: Wed, 2 May 2001 14:54:05 -0400
From: Bill Nottingham <notting@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Debuggers, KDB or KGDB?
Message-ID: <20010502145405.B22385@devserv.devel.redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E14uzuI-0003wC-00@the-village.bc.nu> <200105021906.OAA03542@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200105021906.OAA03542@ccure.karaya.com>; from jdike@karaya.com on Wed, May 02, 2001 at 02:06:31PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike (jdike@karaya.com) said: 
> > > Is this sufficient to do driver development?  TUN/TAP doesn't let me
> > > write 
> > > ethernet drivers inside UML.
> > For ISDN not really. For SCSI yes - scsi generic would let you write a
> > virtual scsi adapter 'owning' some physical devices 
> 
> Fine, so go ahead and write a UML SCSI adapter...  
> 
> I would love to see this happen.  If you need UML help that's not on the site, 
> let me know, and I'll be happy to do what I can.

There is the simulator SCSI, net, and serial drivers in the ia64
tree. Dunno how similar that would be to what you need.

Bill
