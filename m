Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266322AbTAPLFT>; Thu, 16 Jan 2003 06:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266330AbTAPLFT>; Thu, 16 Jan 2003 06:05:19 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:19905 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S266322AbTAPLFS>;
	Thu, 16 Jan 2003 06:05:18 -0500
Date: Thu, 16 Jan 2003 12:14:06 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: MB without keyboard controller / USB-only keyboard ?
Message-ID: <20030116121406.B20652@ucw.cz>
References: <20030109114247.211f7072.skraw@ithnet.com> <20030109232459.A24656@ucw.cz> <20030116120324.2b97e010.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030116120324.2b97e010.skraw@ithnet.com>; from skraw@ithnet.com on Thu, Jan 16, 2003 at 12:03:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2003 at 12:03:24PM +0100, Stephan von Krawczynski wrote:
> On Thu, 9 Jan 2003 23:24:59 +0100
> Vojtech Pavlik <vojtech@suse.cz> wrote:
> 
> > On Thu, Jan 09, 2003 at 11:42:47AM +0100, Stephan von Krawczynski wrote:
> > > Hello all,
> > > 
> > > how do I work with a mb that contains no keyboard controller, but has only
> > > USB for keyboard and mouse?
> > > While booting the kernel I get:
> > > 
> > > pc_keyb: controller jammed (0xFF)
> > > 
> > > (a lot of these :-)
> > > 
> > > and afterwards I cannot use the USB keyboard.
> > > Everything works with a mb that contains a keyboard-controller, but where I
> > > use a USB keyboard.
> > 
> > Get 2.5. ;) It should work without a kbd controller ... you can even
> > disable it in the kernel config ...
> 
> Nice idea, but not acceptable as this setup is for production use, you simply
> won't do that.
> It would be helpful if there was a kernel parameter for disabling the
> keyboard(-check) in 2.4. We found out that disabling it as kernel patch is not
> the right way, as standard setups with keyboard controller do not work any
> longer afterwards. This is a setup where user should be able to choose...
> The box contains a BIOS where I can type around with USB-keyboard, btw.

Anyway, did you try 2.5? I just would like to know if the keyboard
controller is properly not-detected and the system doesn't crash there?

-- 
Vojtech Pavlik
SuSE Labs
