Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133060AbRDRJKQ>; Wed, 18 Apr 2001 05:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133061AbRDRJKH>; Wed, 18 Apr 2001 05:10:07 -0400
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:50059 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S133060AbRDRJJ7>; Wed, 18 Apr 2001 05:09:59 -0400
Date: Wed, 18 Apr 2001 05:00:26 -0400
From: Tim Peeler <tim@iss.dccc.edu>
To: Giuliano Pochini <pochini@shiny.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: I can eject a mounted CD
Message-ID: <20010418050026.A21602@iss.dccc.edu>
In-Reply-To: <E14pcR4-0003E2-00@the-village.bc.nu> <XFMail.010418092543.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <XFMail.010418092543.pochini@shiny.it>; from pochini@shiny.it on Wed, Apr 18, 2001 at 09:25:43AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2001 at 09:25:43AM +0200, Giuliano Pochini wrote:
> 
> >> > /dev/cdrom        /mnt/cdrom        auto        noauto,user,ro    0 0
> >> >
> >> > And remove the other cdrom listing. This will allow mounting any
> >> > supported format and eliminate the duel support for one device.
> >>
> >> That's not the point. The kernel should not allow someone to
> >> eject a mounted media.
> >
> > rpm -e magicdev
> 
> Magicdev is not installed.
> Ok, I'm the only one with this problem, I'll manage to find the bug by myself.

eject(1) line 36:

   If the device is currently mounted, it is unmounted before
   ejecting.


