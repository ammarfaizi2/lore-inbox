Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263774AbREYPih>; Fri, 25 May 2001 11:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263773AbREYPi1>; Fri, 25 May 2001 11:38:27 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:58054 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S263772AbREYPiO> convert rfc822-to-8bit; Fri, 25 May 2001 11:38:14 -0400
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBE2D1@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Erik Mouw'" <J.A.K.Mouw@ITS.TUDelft.NL>,
        "Nemosoft Unv." <nemosoft@smcc.demon.nl>
Cc: Norbert Preining <preining@logic.at>, linux-kernel@vger.kernel.org
Subject: RE: ac15 and 2.4.5-pre6, pwc format conversion
Date: Fri, 25 May 2001 08:37:26 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Erik Mouw [mailto:J.A.K.Mouw@ITS.TUDelft.NL]
> 
> On Fri, May 25, 2001 at 10:48:12AM +0200, Nemosoft Unv. wrote:
> > On 25-May-01 Norbert Preining wrote:
> > > According to ac ChangeLog:
> > > o       Rip format conversion out of the pwc driver     (me)
> > >         | It belongs in user space..
> > > 
> > > This change is included in 2.4.5-pre6, but
> > >       drivers/usb/pwc-uncompress.c
> > > pwc-uncompress.c:185: warning: implicit declaration of function
> > > `vcvt_420i_420p'
> > 
> > That´s what you get for ripping out the guts of a driver. 
> Have a nice day.
> 
> The format conversion shouldn't be there in the first place. Format
> conversion is policy, so it doesn't belong in kernel. Note for example
> that none of the sound drivers does sample rate conversion although
> some sound chips are locked at 48kHz only.

Once upon a time there was an agreement (understanding ?) that this
was to be a major 2.5 change (moving video conversion from kernel
drivers to user space) and that lots of apps would need to be
changed for this to be successful.

~Randy

