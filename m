Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267357AbTA2Wc7>; Wed, 29 Jan 2003 17:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267371AbTA2Wc7>; Wed, 29 Jan 2003 17:32:59 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:25104 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S267357AbTA2Wc6>; Wed, 29 Jan 2003 17:32:58 -0500
Date: Wed, 29 Jan 2003 22:42:20 +0000
From: John Levon <levon@movementarian.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: Switch APIC to driver model (and make S3 sleep with APIC on)
Message-ID: <20030129224220.GA10439@compsoc.man.ac.uk>
References: <200301281219.NAA03575@harpo.it.uu.se> <20030129201843.GA1256@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030129201843.GA1256@elf.ucw.cz>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18e0uS-0006CQ-00*cMmuj1uLxuI*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2003 at 09:18:44PM +0100, Pavel Machek wrote:

> How can this be? I see nmi.c being unconditionaly compiled-in. Where
> are the other clients you are talking about?

Is grep broken ?

> -#if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_PM)
> -EXPORT_SYMBOL_GPL(set_nmi_pm_callback);
> -EXPORT_SYMBOL_GPL(unset_nmi_pm_callback);
> -#endif

You removed these but didn't check where they were used ?

regards
john
