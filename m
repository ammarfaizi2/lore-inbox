Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292319AbSBPIHd>; Sat, 16 Feb 2002 03:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292320AbSBPIHY>; Sat, 16 Feb 2002 03:07:24 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:19974 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S292319AbSBPIHS>; Sat, 16 Feb 2002 03:07:18 -0500
Date: Sat, 16 Feb 2002 09:07:15 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Pavel Machek <pavel@suse.cz>, Rob Landley <landley@trommello.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: small IDE cleanup: void * should not be used unless neccessary
Message-ID: <20020216090715.A8948@suse.cz>
In-Reply-To: <20020213225047.GI1454@elf.ucw.cz> <Pine.LNX.4.10.10202151707440.10501-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10202151707440.10501-100000@master.linux-ide.org>; from andre@linuxdiskcert.org on Fri, Feb 15, 2002 at 05:08:20PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2002 at 05:08:20PM -0800, Andre Hedrick wrote:

> > > I know they're functionally equivalent, but so was the original void
> > > *. :)
> > 
> > Well, void * hides real errors.
> > 
> > > Just an "as long as you're touching this line anyway, why leave the old 
> > > comment?" thing.  A minor, in-passing nit at best...
> > 
> > ide_hwgroup_t is used in 90% of rest of code, so I thought I better
> > leave it there.
> 
> So what do we do with the other 10% break it?  Sheesh :-/

The other 10% won't break by the change, of course.

-- 
Vojtech Pavlik
SuSE Labs
