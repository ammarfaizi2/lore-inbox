Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266408AbTBDLOh>; Tue, 4 Feb 2003 06:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267224AbTBDLOg>; Tue, 4 Feb 2003 06:14:36 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:65287 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S266408AbTBDLOg>; Tue, 4 Feb 2003 06:14:36 -0500
Date: Tue, 4 Feb 2003 12:24:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andreas Jellinghaus <aj@dungeon.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: Compactflash cards dying?
Message-ID: <20030204112406.GB737@atrey.karlin.mff.cuni.cz>
References: <20030202223009.GA344@elf.ucw.cz> <20030203073028.B4C2920BD9@dungeon.inka.de> <20030203125449.GB480@elf.ucw.cz> <1044313953.28406.44.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1044313953.28406.44.camel@imladris.demon.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Ouch... I can't imageine how even VFAT would work on something not
> > 8-bit-clean. I doubt FAT only uses 7bits...
> 
> So use a pseudo-file-system which lets you store 8-bit data on such a
> device storing only 7-bit data. 
> 
> It's no less sensible than taking a real flash device and hacking up a
> pseudo-file-system which makes it pretend to be a block device, then
> using a 'normal' file system on top of that. 
> 
> It's just a shame that CF doesn't generally give you real access to the
> underlying flash and let you use a real file system designed for the
> purpose rather than its silly 'translation layer' :)

Well, if their translation layer at least *worked*, I'd be happy with
it.

Unfortunately one error per 50MB is not acceptable...

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
