Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310192AbSCEUYX>; Tue, 5 Mar 2002 15:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310189AbSCEUYK>; Tue, 5 Mar 2002 15:24:10 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:1039 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S310186AbSCEUYE>;
	Tue, 5 Mar 2002 15:24:04 -0500
Date: Mon, 4 Mar 2002 15:40:38 +0000
From: Pavel Machek <pavel@suse.cz>
To: Dan Maas <dmaas@dcine.com>, "Rose, Billy" <wrose@loislaw.com>,
        linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
Message-ID: <20020304154038.B96@toy.ucw.cz>
In-Reply-To: <fa.n4lfl6v.h4chor@ifi.uio.no> <05cb01c1be1ea01a8c0@allyourbase> <20020225172048.GV20060@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020225172048.GV20060@matchmail.com>; from mfedyk@matchmail.com on Mon, Feb 25, 2002 at 09:20:48AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > but I don't want a Netware filesystem running on Linux, I
> > > want a *native* Linux filesystem (i.e. ext3) that has the
> > > ability to queue deleted files should I configure it to.
> > 
> > Rather than implementing this in the filesystem itself, I'd first try
> > writing a libc shim that overrides unlink(). You could copy files to safety,
> > or do anything else you want, before they actually get deleted...
> 
> Yep, more portable.
> 
> Now the question is: Is there already something written?

Yep, I did it at one point. Then I realized I often kill files with
> file....
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

