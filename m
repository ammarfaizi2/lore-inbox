Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261296AbREQHYk>; Thu, 17 May 2001 03:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261264AbREQHYb>; Thu, 17 May 2001 03:24:31 -0400
Received: from zeus.kernel.org ([209.10.41.242]:63403 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261265AbREQHYR>;
	Thu, 17 May 2001 03:24:17 -0400
Date: Tue, 15 May 2001 14:43:27 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Eric S. Raymond" <esr@thyrsus.com>, Jes Sorensen <jes@sunsite.dk>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 design philosophy heads-up
Message-ID: <20010515144325.A38@toy.ucw.cz>
In-Reply-To: <20010505192731.A2374@thyrsus.com> <d33da9tjjw.fsf@lxplus015.cern.ch> <20010513112543.A16121@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010513112543.A16121@thyrsus.com>; from esr@thyrsus.com on Sun, May 13, 2001 at 11:25:44AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Not all cards have all features, not all users wants to enable all
> > features.
> 
> Yes, I understand that.  You're not reading the derivations correctly.
> Let's take an example:
> 
> derive MVME147_SCSI from MVME147 & SCSI
> 
> This doesn't turn on MVME147_SCSI on every MVME147 board.  It turns
> on MVME147_SCSI when both MVME147 *and SCCI* are on.  So to suppress
> MVME147_SCSI, one just leaves SCCI off.

And If I want scsi-on-atapi emulation but not vme147_scsi?

You are right that your solution is right most of the time, but there
always will be nasty corner cases like that.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

