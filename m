Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266320AbTAPKyj>; Thu, 16 Jan 2003 05:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266322AbTAPKyj>; Thu, 16 Jan 2003 05:54:39 -0500
Received: from mail.ithnet.com ([217.64.64.8]:30987 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S266320AbTAPKyi>;
	Thu, 16 Jan 2003 05:54:38 -0500
Date: Thu, 16 Jan 2003 12:03:24 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: MB without keyboard controller / USB-only keyboard ?
Message-Id: <20030116120324.2b97e010.skraw@ithnet.com>
In-Reply-To: <20030109232459.A24656@ucw.cz>
References: <20030109114247.211f7072.skraw@ithnet.com>
	<20030109232459.A24656@ucw.cz>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jan 2003 23:24:59 +0100
Vojtech Pavlik <vojtech@suse.cz> wrote:

> On Thu, Jan 09, 2003 at 11:42:47AM +0100, Stephan von Krawczynski wrote:
> > Hello all,
> > 
> > how do I work with a mb that contains no keyboard controller, but has only
> > USB for keyboard and mouse?
> > While booting the kernel I get:
> > 
> > pc_keyb: controller jammed (0xFF)
> > 
> > (a lot of these :-)
> > 
> > and afterwards I cannot use the USB keyboard.
> > Everything works with a mb that contains a keyboard-controller, but where I
> > use a USB keyboard.
> 
> Get 2.5. ;) It should work without a kbd controller ... you can even
> disable it in the kernel config ...

Nice idea, but not acceptable as this setup is for production use, you simply
won't do that.
It would be helpful if there was a kernel parameter for disabling the
keyboard(-check) in 2.4. We found out that disabling it as kernel patch is not
the right way, as standard setups with keyboard controller do not work any
longer afterwards. This is a setup where user should be able to choose...
The box contains a BIOS where I can type around with USB-keyboard, btw.

-- 
Regards,
Stephan
