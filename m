Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261990AbTCRFLr>; Tue, 18 Mar 2003 00:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262003AbTCRFLr>; Tue, 18 Mar 2003 00:11:47 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:56463 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id <S261990AbTCRFLq>; Tue, 18 Mar 2003 00:11:46 -0500
Date: Tue, 18 Mar 2003 16:22:57 +1100
From: CaT <cat@zip.com.au>
To: Linus Torvalds <torvalds@transmeta.com>, hch@lst.de
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.65
Message-ID: <20030318052257.GB635@zip.com.au>
References: <Pine.LNX.4.44.0303171429040.2827-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303171429040.2827-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 02:31:01PM -0800, Linus Torvalds wrote:
> I've delayed this too long, but Ingo found why the scheduler sometimes did 

Yaay! I was getting withdrawal symptoms. :)

> bad things, and this should all be good.
> 
> A lot of fairly small changes all over the map, see the full changelog for 
> details.

Aye. Most .config options got lost in the upgrade (I've had to reset
most of them so far).

One question. Should PCMCIA_AHA152X only be compilable as a module? I
found this in Kconfig:

config PCMCIA_AHA152X
        tristate "Adaptec AHA152X PCMCIA support"
        depends on m
        help
          Say Y here if you intend to attach this type of PCMCIA SCSI host
          adapter to your computer.
	  ...

The help and the tristate seems to indicate that I should be able to
compile it into the kernel, but menuconfig wont let me. This is
presumably due to the dependancy but is it right?

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to
kill my dad."
        - George W. Bush Jr, 'President' of Regime of the United States
          September 26, 2002 (from a political fundraiser in Huston, Texas)

