Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbVJKFmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbVJKFmS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 01:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbVJKFmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 01:42:18 -0400
Received: from smtp111.sbc.mail.re2.yahoo.com ([68.142.229.94]:25166 "HELO
	smtp111.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751231AbVJKFmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 01:42:17 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: PS/2 Keyboard under 2.6.x
Date: Tue, 11 Oct 2005 00:42:12 -0500
User-Agent: KMail/1.8.2
Cc: Mark Knecht <markknecht@gmail.com>, mkrufky@m1k.net,
       Robert Crocombe <rwcrocombe@raytheon.com>
References: <434B121A.3000705@raytheon.com> <434B3C82.5080409@m1k.net> <5bdc1c8b0510102148l7faae4c7ke0ce4137b175dfcb@mail.gmail.com>
In-Reply-To: <5bdc1c8b0510102148l7faae4c7ke0ce4137b175dfcb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510110042.13325.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 October 2005 23:48, Mark Knecht wrote:
> On 10/10/05, Michael Krufky <mkrufky@m1k.net> wrote:
> 
> > >My keyboard is a wireless thing that had a little dongle to make it
> > >into ps2. I took that off and used the keyboard as a USB keyboard and
> > >it works fine under SMP.
> > >
> > >This was on 2.6.13-gentoo-r3 for me.
> > >
> > Have either of you tried the kernel boot option usb=handoff ?  I had
> > similar problems, and this fixed it for me.
> >
> > --
> > Michael Krufky
> 
> I have not, but in my case simply using the keyboard as a USB keyboard
> was enough to make it work. What doesn't work is when I use it through
> a dongle as a ps2 keyboard. I'm puzzled as to why usb=handoff would
> fix the ps2 keyboard, but I'm willing to try it tomorrow.
> 

It is "usb-handoff", not "usb=handoff". It instructs BIOS to disable USB
Legacy emulation mode which turns USB keyboard/mouse into emulated PS/2
devices...

-- 
Dmitry
