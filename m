Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286371AbRLTU6Q>; Thu, 20 Dec 2001 15:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286368AbRLTU6G>; Thu, 20 Dec 2001 15:58:06 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:56592 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S286399AbRLTU5x>; Thu, 20 Dec 2001 15:57:53 -0500
Date: Thu, 20 Dec 2001 21:57:51 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: m.luca@iname.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] Trident 4DWave DX/NX joystick support
Message-ID: <20011220215751.A31836@suse.cz>
In-Reply-To: <3C21229F.A6864423@iname.com> <20011220153855.C30746@suse.cz> <3C220C45.FD0D1CB2@teamfab.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C220C45.FD0D1CB2@teamfab.it>; from luca.montecchiani@teamfab.it on Thu, Dec 20, 2001 at 05:05:25PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 05:05:25PM +0100, Luca Montecchiani wrote:

> > I must say I don't like the patch much. 
> 
> There are couples of other pci cards that do the same
> and right now is the only way to make joystick works with
> trident sound card.
> I hope to help some users around here.
> 
> > If there is anything going to be added to trident.c 
> > in regards to enabling the joystick, I think most of
> > the pcigame.c code should be moved in there.
> 
> Not necessary, 2.2.19 joy-pci code works fine, no conflict
> no oops, what about comparing against 2.4.x pcigame ?
> 
> Unfortunately I don't know how do that, but I can help you
> testing patch, etc...
> 
> I hope to provide you the oops I've got insmodding analog
> tomorrow.

If you'll be able to get me the decoded oops, I'll be very grateful,
because I've got some reports about analog oopsing and I haven't been
able to reproduce that.

> > That way, there won't be
> > resource conflicts and we won't lose any functionality.
> 
> I don't understand where the problem came from, with
> 2.2.19 everything work fine, I can use the joy-pci with
> the trident module up and running, with the 2.4.17rc2
> trident and pcigame are mutually exclusive.
> Because of the 2.4.x pci changes ? Let's see.

-- 
Vojtech Pavlik
SuSE Labs
