Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130199AbRBMFiB>; Tue, 13 Feb 2001 00:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130267AbRBMFhv>; Tue, 13 Feb 2001 00:37:51 -0500
Received: from cherry.napri.sk ([194.1.128.4]:36114 "HELO cherry.napri.sk")
	by vger.kernel.org with SMTP id <S130199AbRBMFhg>;
	Tue, 13 Feb 2001 00:37:36 -0500
Date: Mon, 12 Feb 2001 18:18:00 +0100
From: Peter Kundrat <kundrat@kundrat.sk>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Animated framebuffer logo for 2.4.1
Message-ID: <20010212181800.A27031@napri.sk>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3A83B6B0.8261F3CF@idb.hist.no> <3A83C4A1.5090903@megapathdsl.net> <20010211234718.K3748@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0i
In-Reply-To: <20010211234718.K3748@bug.ucw.cz>; from pavel@suse.cz on Sun, Feb 11, 2001 at 11:47:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2001 at 11:47:18PM +0100, Pavel Machek wrote:
> > Right.  Add the option.  Default to "spew mode",
> > but make it easy for distributions to show people
> > a non-threatening boot process.  
> 
> Wrong.
> > 
> > Since, as Christophe mentions, the boot messages would
> > still be accessible via CTRL-ALT-F2, I don't see what 
> > the problem is with at least making this an option.
> 
> If your system crashes hard, you have only graphical logo to stare
> at. Any warning messages are hidden. Not good.

One good compromise would be a small scrolling window with a few last kernel messages.
Another option would be to turn it off for next boot (assuming it is reproducible), 
either by setting bootparam or pressing alt-f2 early enough.

		pkx
-- 
Peter Kundrat
peter@kundrat.sk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
