Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263340AbUEPIUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbUEPIUL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 04:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbUEPIUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 04:20:10 -0400
Received: from lucidpixels.com ([66.45.37.187]:2980 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S263340AbUEPIUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 04:20:05 -0400
Date: Sun, 16 May 2004 04:20:03 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: Stan Bubrouski <stan@ccs.neu.edu>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.5 emu10k1 module FAILS, built-in OK.
In-Reply-To: <1084676229.21547.0.camel@duergar>
Message-ID: <Pine.LNX.4.58.0405160418500.14264@p500>
References: <Pine.LNX.4.58.0405151530590.16044@p500> <1084676229.21547.0.camel@duergar>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Because it supports the /app/emu-tools-0.9.4/ option.

default has rear end speakers but it is not "surround"/5.1/etc/

./emu-script (loads rear-end speaker support for surround + AC3 option,
ALSA does *NOT* have AC3 capability))

On Sat, 15 May 2004, Stan Bubrouski wrote:

> On Sat, 2004-05-15 at 15:32, Justin Piszcz wrote:
> > Script started on Sat May 15 14:47:08 2004
> > # modprobe emu10k1
> > FATAL: Error inserting emu10k1
> > (/lib/modules/2.6.5/kernel/sound/oss/emu10k1/emu10k1.ko): Unknown symbol
>
> Umm...why are you using OSS for emu10k instead of ALSA?
>
> -sb
>
> > in module, or unknown parameter (see dmesg)
> > root@war:~# dmesg | tail -n 1
> >  emu10k1: Unknown symbol strcpy
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
