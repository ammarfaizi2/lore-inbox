Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVA2TKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVA2TKx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 14:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVA2TIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 14:08:44 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:61390 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261532AbVA2TII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 14:08:08 -0500
Date: Fri, 28 Jan 2005 19:41:22 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: Wiktor <victorjan@poczta.onet.pl>, linux-kernel@vger.kernel.org
Subject: Re: AT keyboard dead on 2.6
Message-ID: <20050128184122.GB2640@ucw.cz>
References: <41F11F79.3070509@poczta.onet.pl> <d120d500050121074831087013@mail.gmail.com> <41F15307.4030009@poczta.onet.pl> <d120d500050121113867c82596@mail.gmail.com> <41F69FFE.2050808@poczta.onet.pl> <20050128143121.GB12137@ucw.cz> <d120d50005012806467cc5ee03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d50005012806467cc5ee03@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 09:46:41AM -0500, Dmitry Torokhov wrote:
> On Fri, 28 Jan 2005 15:31:21 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > On Tue, Jan 25, 2005 at 08:37:34PM +0100, Wiktor wrote:
> > > Hi,
> > >
> > > here you are gzip-ed dmesg from booting 2.6.8.1 - i've been playing
> > > keyboard while booting, maybe interrupt reports will help you. also my
> > > .config part follows:
> > > CONFIG_INPUT=y
> > > CONFIG_INPUT_MOUSEDEV=y
> > > CONFIG_SOUND_GAMEPORT=y
> > > CONFIG_SERIO=y
> > > CONFIG_SERIO_I8042=y
> > > CONFIG_INPUT_KEYBOARD=y
> > > CONFIG_KEYBOARD_ATKBD=y
> > > no modules or other built-ins. maybe it is some simple way to fall back
> > > to old handling mechanism? in my system most of programs (i mean
> > > x-server) uses hardware directly (what means uses /dev/ttyS0 as mouse
> > > device). i'm grateful for any help.
> > 
> > This dmesg looks like the keyboard works perfectly OK. Do new lines
> > appear in dmesg when you press keys while the system is running?
> >
> 
> It does no report any IDs but ACKs GETID command. Not very nice...
 
Very old AT keyboards can do that.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
