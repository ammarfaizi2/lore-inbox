Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbTJWUIP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 16:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbTJWUIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 16:08:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:6855 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261775AbTJWUIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 16:08:13 -0400
Date: Thu, 23 Oct 2003 10:24:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: M?ns Rullg?rd <mru@users.sourceforge.net>,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PM][ACPI] No ACPI interrupts after resume from S1
Message-ID: <20031023082410.GC643@openzaurus.ucw.cz>
References: <20031020141512.GA30157@hell.org.pl> <yw1x8yngj7xg.fsf@users.sourceforge.net> <20031020184750.GA26154@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031020184750.GA26154@hell.org.pl>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > working.  Normally, they will generate an ACPI event, that is
> > processed by acpid etc.  After a suspend, each button will work once.
> > If I then close and open the lid, they will work one more time, and so
> > on.  Any way I can help?
> 
> Please specify the type of suspend. The situation I described only occurs
> for S1 (or, echo -n standby, more specifically), and only in certain kernel
> versions.

Find out which versions break it, pay special atetion to
hwsleep.c.
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

