Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273269AbRKHMMI>; Thu, 8 Nov 2001 07:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276894AbRKHML7>; Thu, 8 Nov 2001 07:11:59 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:46076 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S273269AbRKHMLy>; Thu, 8 Nov 2001 07:11:54 -0500
Date: Thu, 8 Nov 2001 07:11:51 -0500
From: Arjan van de Ven <arjanv@redhat.com>
To: "Zvi Har'El" <rl@math.technion.ac.il>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
        "Nadav Har'El" <nyh@math.technion.ac.il>
Subject: Re: ext3 vs resiserfs vs xfs
Message-ID: <20011108071151.A16254@devserv.devel.redhat.com>
In-Reply-To: <3BEA6725.739463C2@redhat.com> <Pine.GSO.4.33.0111081407130.28492-100000@leeor.math.technion.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.33.0111081407130.28492-100000@leeor.math.technion.ac.il>; from rl@math.technion.ac.il on Thu, Nov 08, 2001 at 02:10:58PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2001 at 02:10:58PM +0200, Zvi Har'El wrote:
> On Thu, 8 Nov 2001, Arjan van de Ven wrote:
> 
> >
> > The basic idea is "everything which can be a module will be a module",
> > even scsi is a module. And if you use grub, it's 100% transparent as the
> > initrd
> > will be automatically added to the grub config when you install the RH
> > kernel rpm;
> > even if you use lilo the initrd is supposed to be made for you
> 
> Is there no overhead (except in boot time) in using initrd?

The initrd memory is freed during the initial boot so there's no overhead.

