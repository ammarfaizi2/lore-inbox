Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269113AbUICH1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269113AbUICH1r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 03:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269247AbUICH1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 03:27:46 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:35671 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269113AbUICH1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 03:27:44 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Subject: Re: [2.6.8.1-mm1][input] - IBM TouchPad support added? Which patch is this? - Unsure still
Date: Fri, 3 Sep 2004 02:27:42 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200408170349.44626.shawn.starr@rogers.com> <200408170801.00068.dtor_core@ameritech.net> <41381972.8080600@bio.ifi.lmu.de>
In-Reply-To: <41381972.8080600@bio.ifi.lmu.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409030227.42441.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 September 2004 02:12 am, Frank Steiner wrote:
> Dmitry Torokhov wrote:
> > On Tuesday 17 August 2004 03:02 am, Shawn Starr wrote:
> > 
> >>Sorry, I stand corrected. I don't know where this patch is added from which 
> >>enables the touchpad to act as a 'button press'.
> >>
> > 
> > 
> > mousedev now does tap emulation for touchpads working in absolute mode
> > (Synaptics) so you don't need to use psmouse.proto= parameter to force
> > it in PS/2 compatibility mode. Use mousedev.tap_time= option to control
> > it.
> > 
> > The patch is only in -mm at the moment.
> 
> Can that patch be downloaded somewhere to patch against 2.6.8.1? I don't
> have any tapping support for my synaptic touchpad on my compaq laptop after
> switching from 2.4 to 2.6.
> It seems that most of the patches at http://www.geocities.com/dt_or/input/2_6_7/
> are already in 2.6.8.1: Just the tapping stuff seems to be missing. And
> I can't extract your patch from the 2.6.9-rc1-mm2 stuff, because it seems
> to be mixed with some other patches there.
> Is there a sole version of this patch fir 2.6.8.1 somewhere?
> 

No, I don't think I have one... If you are using BitKeeper, yo could just do:

	bk pull bk://dtor.bkbits.net/input

But have you tried installing XFree86/XOrg Synaptics driver
(http://w1.894.telia.com/~u89404340/touchpad/index.html)?
It does support tapping just fine...

-- 
Dmitry
