Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbTJWUJi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 16:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbTJWUIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 16:08:22 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:7111 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261776AbTJWUIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 16:08:13 -0400
Date: Thu, 23 Oct 2003 10:25:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: pavel@ucw.cz
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [PM][ACPI] No ACPI interrupts after resume from S1
Message-ID: <20031023082534.GD643@openzaurus.ucw.cz>
References: <20031020141512.GA30157@hell.org.pl> <yw1x8yngj7xg.fsf@users.sourceforge.net> <20031020184750.GA26154@hell.org.pl> <yw1xekx7afrz.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1xekx7afrz.fsf@kth.se>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> suspend, the extra buttons (I use them to fire up programs) stop
> >> working.  Normally, they will generate an ACPI event, that is
> >> processed by acpid etc.  After a suspend, each button will work once.
> >> If I then close and open the lid, they will work one more time, and so
> >> on.  Any way I can help?
> >
> > Please specify the type of suspend. The situation I described only occurs
> > for S1 (or, echo -n standby, more specifically), and only in certain kernel
> > versions.
> 
> standby, at least.
> 
> After echo -n mem > /sys/power/state, the display light won't turn on,
> so I don't know what's going on.  I've never managed to resume from a
> suspend to disk.  It just boots normally and makes a fuss about the
> filesystems.

Are you passing resume= option?
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

