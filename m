Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316897AbSGIRDQ>; Tue, 9 Jul 2002 13:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317005AbSGIRDP>; Tue, 9 Jul 2002 13:03:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:15878 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316897AbSGIRDL>; Tue, 9 Jul 2002 13:03:11 -0400
Date: Tue, 9 Jul 2002 19:05:54 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net
Subject: Re: [uml-user] Re: user-mode port 0.58-2.4.18-36
Message-ID: <20020709170554.GC31838@atrey.karlin.mff.cuni.cz>
References: <20020709031618.GC113@elf.ucw.cz> <200207091655.LAA02540@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207091655.LAA02540@ccure.karaya.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > ...and using CAP_SYS_RAWIO... 
> 
> ... or were you complaining about 'jail' turning off CAP_SYS_RAWIO, rather
> than claiming that it is an unplugged hole?

I thought it was that. It was mostly for other list users that may try
to setup their UML jail, and forget about this.

> If so, that may be a problem, but I haven't seen anything that cares about
> CAP_SYS_RAWIO being off.  That was the simplest way I could find to disable
> writing to /dev/kmem.

I don't understand here. So UML never ever permits access to
/dev/kmem? If so that is rather strange architecture.
									Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
