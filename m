Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278613AbRJVLZJ>; Mon, 22 Oct 2001 07:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278520AbRJVLY7>; Mon, 22 Oct 2001 07:24:59 -0400
Received: from hal.astr.lu.lv ([195.13.134.67]:47111 "EHLO hal.astr.lu.lv")
	by vger.kernel.org with ESMTP id <S278613AbRJVLYj>;
	Mon, 22 Oct 2001 07:24:39 -0400
Message-Id: <200110221115.f9MBFGG03559@hal.astr.lu.lv>
Content-Type: text/plain; charset=US-ASCII
From: Andris Pavenis <pavenis@latnet.lv>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.12-ac5: i810_audio does not work
Date: Mon, 22 Oct 2001 14:15:16 +0300
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15vcbD-0001Vn-00@the-village.bc.nu>
In-Reply-To: <E15vcbD-0001Vn-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 October 2001 13:46, Alan Cox wrote:
> > Sound practically doesn't work under KDE-2.2.1. For example I'm getting
> > only some garbled sound for a very short time when I'm trying sound test
> > in kcontrol. Maybe these problems are due to non blocking output to
> > /dev/sound/dsp which artsd is using. Here is fragment from strace output
> > for artsd
>
> Do you know which release it actually broke for you ? By -ac5 there are
> both core changes and multi-channel stuff that might be involved

It's difficult to say exactly as it's broken already for a rather long time:
	kernels beginning 2.4.9 (if I remeber correctly) have trouble with  
		i810_audio under KDE-2.2
	the same about 2.4.6-ac2 and later ones

Earlier I found some combination (some 2.4.8-ac or soimething similar with 
reverted one of the patches between 2.4.6-ac1 and 2.4.6-ac2) which mostly 
works for KDE with fragment size up to 512 bytes. 2.4.7 worked with any fragment 
size set in kcontrol.

I haven't tested much under GNOME, as I'm starting it very seldom

Andris
