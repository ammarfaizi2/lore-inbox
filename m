Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284122AbRLWTxc>; Sun, 23 Dec 2001 14:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284133AbRLWTxW>; Sun, 23 Dec 2001 14:53:22 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:3344 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S284122AbRLWTxQ>;
	Sun, 23 Dec 2001 14:53:16 -0500
Date: Sun, 23 Dec 2001 20:53:14 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: really mason_at_soo_dot_com <lnx-kern@Sophia.soo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre1 oddness under X
Message-ID: <20011223205314.A13754@suse.cz>
In-Reply-To: <20011222164602.A20623@Sophia.soo.com> <3C250835.9010806@wanadoo.fr> <20011223151147.F7438@suse.de> <20011223120825.A22239@Sophia.soo.com> <20011223204227.A13661@suse.cz> <20011223144800.A22538@Sophia.soo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011223144800.A22538@Sophia.soo.com>; from lnx-kern@Sophia.soo.com on Sun, Dec 23, 2001 at 02:48:00PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2001 at 02:48:00PM -0500, really mason_at_soo_dot_com wrote:
> Yeps, i do have that param in lilo.conf. 

Good, then. In theory your IDE should operate well if you did this,
eventhough you run the 37 MHz PCI. Other devices may not like this
still, though.

> i thot it
> was only relevant to PIO modes?  Shows how little i
> know abt the IDE drivers.

It is relevant to all PIO, DMA and UDMA modes.

> 
> b
> 
> On Sun, Dec 23, 2001 at 08:42:27PM +0100, Vojtech Pavlik wrote:
> > On Sun, Dec 23, 2001 at 12:08:25PM -0500, really mason_at_soo_dot_com wrote:
> > >  i also have the FSB overclocked so
> > > the PCI bus is running at 37mhz.
> > 
> > And you did tell the VIA ide driver to compensate for the 37MHz, did
> > you? ('idebus=37' kernel option)

-- 
Vojtech Pavlik
SuSE Labs
