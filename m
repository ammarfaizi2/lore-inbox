Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310743AbSCNHbG>; Thu, 14 Mar 2002 02:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310859AbSCNHaz>; Thu, 14 Mar 2002 02:30:55 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:41741 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S310743AbSCNHak>; Thu, 14 Mar 2002 02:30:40 -0500
Date: Thu, 14 Mar 2002 08:30:38 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Daniela Engert <dani@ngrt.de>
Cc: Shawn Starr <spstarr@sh0n.net>, Vojtech Pavlik <vojtech@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Martin Dalecki <martin@dalecki.de>
Subject: Re: [patch] PIIX rewrite patch, pre-final
Message-ID: <20020314083038.A31923@ucw.cz>
In-Reply-To: <20020314075258.A31815@ucw.cz> <20020314061803.EDF56E415@mail.medav.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020314061803.EDF56E415@mail.medav.de>; from dani@ngrt.de on Thu, Mar 14, 2002 at 08:24:02AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 08:24:02AM +0100, Daniela Engert wrote:
> On Thu, 14 Mar 2002 07:52:58 +0100, Vojtech Pavlik wrote:
> 
> >> This will benifit PIIX3 chipsets? :)
> >It should.
> 
> Are you aware of the batches of broken PIIX3 chips ?

I don't know of any IDE-related errata for the PIIX3 chip. At least
Intel didn't publish any and there doesn't seem to be any workarounds in
the original piix.c code, only a statement stating that the PIIX3 UDMA
is broken, however, as far as I know, PIIX3 isn't UDMA capable at all.

(Hmm, perhaps some BIOSes enable UDMA on PIIX3, that'd explain it ...
though I believe that's quite improbable).

In what way are those batches broken?

-- 
Vojtech Pavlik
SuSE Labs
