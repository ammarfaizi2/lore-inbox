Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291397AbSBXVqI>; Sun, 24 Feb 2002 16:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291414AbSBXVqA>; Sun, 24 Feb 2002 16:46:00 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:58884 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S291397AbSBXVpj>; Sun, 24 Feb 2002 16:45:39 -0500
Date: Sun, 24 Feb 2002 22:45:36 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Ben Clifford <benc@hawaga.org.uk>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.5-dj1 - problem with /dev/input/mice
Message-ID: <20020224224536.A1997@ucw.cz>
In-Reply-To: <20020224222708.A1814@ucw.cz> <Pine.LNX.4.33.0202241338490.11220-100000@barbarella.hawaga.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0202241338490.11220-100000@barbarella.hawaga.org.uk>; from benc@hawaga.org.uk on Sun, Feb 24, 2002 at 01:42:34PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2002 at 01:42:34PM -0800, Ben Clifford wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Sun, 24 Feb 2002, Vojtech Pavlik wrote:
> 
> > That's interesting. It almost looks like if the Xserver messed with the
> > mouse hardware somehow, which I hope it can't.
> 
> > Does 'dmesg' say anything relevant?
> 
> I don't think so.
> 
> All that appears is an mtrr message about alignment, that I think I has
> appeared for several kernel versions.
> 
> > I can help you find the cause - if you enable I8042_DEBUG_IO in
> > drivers/input/serio/i8042.h, you'll see all the data coming in and out
> > to the keyboard/aux controller.
> 
> Compiling now...

Ok, waiting ... :)

-- 
Vojtech Pavlik
SuSE Labs
