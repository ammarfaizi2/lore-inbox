Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269390AbTCDLt4>; Tue, 4 Mar 2003 06:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269391AbTCDLtz>; Tue, 4 Mar 2003 06:49:55 -0500
Received: from poup.poupinou.org ([195.101.94.96]:33305 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S269390AbTCDLty>; Tue, 4 Mar 2003 06:49:54 -0500
Date: Tue, 4 Mar 2003 13:00:15 +0100
To: Pavel Machek <pavel@suse.cz>
Cc: Ducrot Bruno <ducrot@poupinou.org>, Pavel Machek <pavel@ucw.cz>,
       Andrew Grover <andrew.grover@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] S4bios support for 2.5.63
Message-ID: <20030304120015.GB7861@poup.poupinou.org>
References: <20030226211347.GA14903@elf.ucw.cz> <20030227141322.GV13404@poup.poupinou.org> <20030304132329.GF618@zaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030304132329.GF618@zaurus.ucw.cz>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 04, 2003 at 02:23:29PM +0100, Pavel Machek wrote:
> Hi!
> 
> 
> > > +
> > > +	do {
> > > +		acpi_os_stall(1000);
> > > +		status = acpi_get_register (ACPI_BITREG_WAKE_STATUS, &in_value, ACPI_MTX_LOCK);
> > 
> > Please use ACPI_MTX_DO_NOT_LOCK flags.
> 
> Is s/MTX_LOCK/MTX_DO_NOT_LOCK/
> enough?
> 

Never mind.  Someone has already made the modif.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
