Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbTKDQXr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 11:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbTKDQXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 11:23:46 -0500
Received: from ezoffice.mandrakesoft.com ([212.11.15.34]:39569 "EHLO
	vador.mandrakesoft.com") by vger.kernel.org with ESMTP
	id S262337AbTKDQXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 11:23:45 -0500
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Tomas Szepe <szepe@pinerecords.com>, Valdis.Kletnieks@vt.edu,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: how to restart userland?
X-URL: <http://www.linux-mandrake.com/
References: <20031103193940.GA16820@louise.pinerecords.com>
	<200311032003.hA3K3tgv017273@turing-police.cc.vt.edu>
	<20031103201223.GC16820@louise.pinerecords.com>
	<3FA779F5.6090704@aitel.hist.no>
From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Organization: MandrakeSoft
Date: Tue, 04 Nov 2003 15:47:26 +0000
In-Reply-To: <3FA779F5.6090704@aitel.hist.no> (Helge Hafting's message of
 "Tue, 04 Nov 2003 11:05:41 +0100")
Message-ID: <m2ptg8rv8x.fsf@vador.mandrakesoft.com>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helgehaf@aitel.hist.no> writes:

> > > Is there a reason you want to "completely" restart userland and
> > > *not* reboot (for instance, wanting to keep existing mounts,
> > > etc)?
> > Extensive userland upgrades (glibc is a nice example I guess),
> > etc.
>
> Consider using debian then - a glibc upgrade there is no problem as
> various services (including init) are restarted automatically mostly
> without disturbing running applications.

this should be mandatory in the packaging system.
mandrake too restart servers on glibc update.

this is definitively not a kernel problem, but a userland one.

