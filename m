Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264771AbUEaUHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264771AbUEaUHE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 16:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264770AbUEaUHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 16:07:03 -0400
Received: from mail-ext.curl.com ([66.228.88.132]:7693 "HELO mail-ext.curl.com")
	by vger.kernel.org with SMTP id S264772AbUEaUGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 16:06:55 -0400
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.x partition breakage and dual booting
References: <40BA2213.1090209@pobox.com>
	<20040530183609.GB5927@pclin040.win.tue.nl>
	<40BA2E5E.6090603@pobox.com> <20040530200300.GA4681@apps.cwi.nl>
	<s5g8yf9ljb3.fsf@patl=users.sf.net>
	<20040531180821.GC5257@louise.pinerecords.com>
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5gaczonzej.fsf@patl=users.sf.net>
Date: 31 May 2004 16:06:54 -0400
In-Reply-To: <20040531180821.GC5257@louise.pinerecords.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Szepe <szepe@pinerecords.com> writes:

> > This is really very simple.  If you move a disk from a machine with a
> > different BIOS and you preserve the partition table geometry, you will
> > NEVER be able to install Windows on the drive.  If you partition a
> > blank drive and use the wrong geometry, you will NEVER be able to
> > install Windows on the drive.
> 
> I don't quite believe this.  AFAICT the Windows 2000/XP install
> program will succeed no matter what, the only problem is with
> getting the dirty thing to boot AFTER install has completed.  If it
> craps out, boot off the install CD to the repair console prompt, run
> fixboot/fixmbr and all should be swell.  If you need dual boot, you
> can go ahead and reinstall lilo/grub at this point.

Well, sure.  You could also erase the entire disk and start over.  I
did not literally mean "never"; sorry if that was not obvious.

The point is, if you use the wrong geometry in the partition table,
Windows will not boot.  You could always fix it later, either from
Linux (sfdisk hack) or from the Windows recovery console or with a hex
editor or whatever.  The topic of discussion was how to get it right
to begin with.

 - Pat
