Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318784AbSHLSiS>; Mon, 12 Aug 2002 14:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318785AbSHLSiS>; Mon, 12 Aug 2002 14:38:18 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:16655 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318784AbSHLSiR>;
	Mon, 12 Aug 2002 14:38:17 -0400
Date: Mon, 12 Aug 2002 11:38:20 -0700
From: Greg KH <greg@kroah.com>
To: David Fries <dfries@mail.win.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: via vp3 udma corruption
Message-ID: <20020812183820.GN15975@kroah.com>
References: <20020811210826.GA684@spacedout.fries.net> <20020812170232.GC15249@kroah.com> <20020812182558.GB677@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020812182558.GB677@spacedout.fries.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 15 Jul 2002 17:22:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2002 at 01:25:58PM -0500, David Fries wrote:
> I ran oldconfig, but I probably just said, 'USB I have all the drivers
> I need, NO', but thanks, I figured out that option when I read the USB
> mailing list.
> 
> Are there alternate ways of getting data to the /dev/usb/mice type
> devices CONFIG_INPUT_MOUSEDEV?  (Major 13, Minor 63), or shouldn't an
> open to that device fail with no device if CONFIG_USB_HIDINPUT isn't
> enabled?

I think any input mouse driver will send data to that device.  If you
have that config option enabled, an open will always succeed.  Talk to
the input core authors for more information.

Hope this helps,

gregk -h
