Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285974AbRLHVfW>; Sat, 8 Dec 2001 16:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285973AbRLHVfM>; Sat, 8 Dec 2001 16:35:12 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:43268 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S285975AbRLHVfA>; Sat, 8 Dec 2001 16:35:00 -0500
Date: Sat, 8 Dec 2001 22:34:57 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jonathan Isom <jisom@ematic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: es1371 & joystick
Message-ID: <20011208223457.A21138@suse.cz>
In-Reply-To: <12402.1007833451@defiant.getmyip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <12402.1007833451@defiant.getmyip.com>; from jisom@ematic.com on Sun, Dec 09, 2001 at 01:44:11AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2001 at 01:44:11AM +0800, Jonathan Isom wrote:
> When I upgraded from 2.4.6 to 2.4.16 my gamepad stopped working. All the proper modules are created but I get is:
> 
> /lib/modules/2.4.16/kernel/drivers/char/joystick/ns558.o: init_module: No such device  
> 
> Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters  
> 
> /lib/modules/2.4.16/kernel/drivers/char/joystick/ns558.o: insmod /lib/modules/2.4.16/kernel/drivers/char/joystick/ns558.o failed  
> 
> /lib/modules/2.4.16/kernel/drivers/char/joystick/ns558.o: insmod joystick failed   
> 
> My modules.conf and .config are attached. The card is a SoundBlaser 16 pci.

The answer is simple: Don't load the ns558.o module, it's not needed
anymore with es1371.


-- 
Vojtech Pavlik
SuSE Labs
