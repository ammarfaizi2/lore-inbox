Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267769AbTBKLEa>; Tue, 11 Feb 2003 06:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267791AbTBKLEE>; Tue, 11 Feb 2003 06:04:04 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:2820 "EHLO probity.mcc.ac.uk")
	by vger.kernel.org with ESMTP id <S267769AbTBKLCo>;
	Tue, 11 Feb 2003 06:02:44 -0500
Date: Tue, 11 Feb 2003 11:12:31 +0000
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org
Cc: pavel@suse.cz
Subject: Re: Switch APIC (+nmi, +oprofile) to driver model
Message-ID: <20030211111231.GG53481@compsoc.man.ac.uk>
References: <200302091407.PAA14076@kim.it.uu.se> <20030210110108.GE2838@atrey.karlin.mff.cuni.cz> <20030210115034.GF22600@compsoc.man.ac.uk> <20030210200606.GE154@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030210200606.GE154@elf.ucw.cz>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18iYL1-000BAE-00*2KI77ETOf5Y*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 09:06:06PM +0100, Pavel Machek wrote:

> > > Yes, whole oprofile/nmi interaction is ugly like hell. This way it is
> > > at least explicit, so people *know* its ugly.
> > 
> > That's no reason not do something like Mikael or I suggested.
> 
> makes what happens there pretty explicit. Whole thing can be
> controlled by single variable...
> 
> Here's new version of diff...

Are you going to continue ignoring me when I point out the bugs in your
patch ? You're still not exporting nmi_watchdog,setup/disable_watchdog
to modules.

Of course, exporting three things when you only need two is ugly, but
since you refuse to do it like that ...

john
