Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266633AbUBEVGr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 16:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266636AbUBEVGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 16:06:46 -0500
Received: from gprs146-127.eurotel.cz ([160.218.146.127]:12417 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S266633AbUBEVGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 16:06:45 -0500
Date: Thu, 5 Feb 2004 22:06:23 +0100
From: Pavel Machek <pavel@suse.cz>
To: John Bradford <john@grabjohn.com>
Cc: Jens Axboe <axboe@suse.de>, Tomas Zvala <tomas@zvala.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0, cdrom still showing directories after being erased
Message-ID: <20040205210623.GA1541@elf.ucw.cz>
References: <20040203131837.GF3967@aurora.fi.muni.cz> <Pine.LNX.4.53.0402030839380.31203@chaos> <401FB78A.5010902@zvala.cz> <20040203152805.GI11683@suse.de> <20040205182335.GB294@elf.ucw.cz> <200402052004.i15K4Bqx000266@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402052004.i15K4Bqx000266@81-2-122-30.bradfords.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > mount
> > umount
> > cdrecord -blank
> > mount
> > see old data
> > 
> > That looks pretty bad. If there's no other solution, we might just
> > document it, but...
> 
> I think cdrecord should be hacked to complain loudly if the device is
> already mounted.  Regardless of the device cache not being cleared,
> (which is a firmware bug, in my opinion), blanking a mounted device is
> usually not what the user intended.  This is not a kernel problem as
> such, and should be dealt with in userspace.

But it is _not_ mounted at that point. User did no mistake.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
