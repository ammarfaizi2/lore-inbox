Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311360AbSCNHqh>; Thu, 14 Mar 2002 02:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311149AbSCNHq0>; Thu, 14 Mar 2002 02:46:26 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:5134 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S311072AbSCNHqS>;
	Thu, 14 Mar 2002 02:46:18 -0500
Date: Thu, 14 Mar 2002 08:46:15 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Daniela Engert <dani@ngrt.de>,
        Shawn Starr <spstarr@sh0n.net>, LKML <linux-kernel@vger.kernel.org>,
        Martin Dalecki <martin@dalecki.de>
Subject: Re: [patch] PIIX rewrite patch, pre-final
Message-ID: <20020314084615.A31998@ucw.cz>
In-Reply-To: <20020314083038.A31923@ucw.cz> <Pine.LNX.4.10.10203132334450.21396-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10203132334450.21396-100000@master.linux-ide.org>; from andre@linux-ide.org on Wed, Mar 13, 2002 at 11:36:30PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2002 at 11:36:30PM -0800, Andre Hedrick wrote:

> On Thu, 14 Mar 2002, Vojtech Pavlik wrote:
> 
> > On Thu, Mar 14, 2002 at 08:24:02AM +0100, Daniela Engert wrote:
> > > On Thu, 14 Mar 2002 07:52:58 +0100, Vojtech Pavlik wrote:
> > > 
> > > >> This will benifit PIIX3 chipsets? :)
> > > >It should.
> > > 
> > > Are you aware of the batches of broken PIIX3 chips ?
> > 
> > I don't know of any IDE-related errata for the PIIX3 chip. At least
> > Intel didn't publish any and there doesn't seem to be any workarounds in
> > the original piix.c code, only a statement stating that the PIIX3 UDMA
> > is broken, however, as far as I know, PIIX3 isn't UDMA capable at all.
> 
> 27296302.pdf    82371SB (PIIX3) Timing Specification
> 29765804.pdf    INTEL 82371FB (PIIX) and 82371SB (PIIX3) SPECIFICATION UPDATE

Gee, thanks, like if I haven't read those twice over already. No mention
of UDMA (or SDMA in Intel speech), or any IDE errata anyway.

-- 
Vojtech Pavlik
SuSE Labs
