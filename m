Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279313AbRKVNcY>; Thu, 22 Nov 2001 08:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279407AbRKVNcO>; Thu, 22 Nov 2001 08:32:14 -0500
Received: from ns.suse.de ([213.95.15.193]:55052 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S279313AbRKVNcC> convert rfc822-to-8bit;
	Thu, 22 Nov 2001 08:32:02 -0500
To: Ado.Arnolds@dhm-systems.de
Cc: Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk
Subject: Re: fs/exec.c and binfmt-xxx in 2.4.14
In-Reply-To: <3BFBDD32.434AB47B@web-systems.net>
	<20011121211433.B1424@devcon.net> <3BFCE5BB.AD59B011@web-systems.net>
X-Yow: While you're chewing, think of STEVEN SPIELBERG'S
 bank account..  This will have the same effect as
 two ``STARCH BLOCKERS''!
From: Andreas Schwab <schwab@suse.de>
Date: 22 Nov 2001 14:31:55 +0100
In-Reply-To: <3BFCE5BB.AD59B011@web-systems.net> (Heinz-Ado Arnolds's message of "Thu, 22 Nov 2001 12:47:07 +0100")
Message-ID: <jed72b7wz8.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.1.30
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heinz-Ado Arnolds <Ado.Arnolds@dhm-systems.de> writes:

|> Andreas Ferber wrote:
|> > 
|> > On Wed, Nov 21, 2001 at 05:58:26PM +0100, Heinz-Ado Arnolds wrote:
|> > >
|> > > When i now try to start an older binary in a.out format, which has a
|> > > magic number of 0x010b0064, it is translated with the 'new' code to a
|> > > request for "binfmt-0064" instead of "binfmt-267" as expected and
|> > > properly handled by modprobe.
|> > 
|> > Then add
|> > 
|> > alias binfmt-0064 binfmt_aout
|> > 
|> > to /etc/modules.conf. Simple, isn't it?
|> 
|> That's a nice idea but I wouldn't rely on the fact that the third
|> and the fourth byte of a file are sufficient to identify the type.

Moreover, it is not endian clean.  But that was also true for the old
scheme.

Andreas.

-- 
Andreas Schwab                                  "And now for something
Andreas.Schwab@suse.de				completely different."
SuSE Labs, SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
