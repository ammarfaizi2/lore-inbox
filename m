Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266791AbUBEVTM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 16:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266785AbUBEVTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 16:19:12 -0500
Received: from gprs146-127.eurotel.cz ([160.218.146.127]:15745 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S266791AbUBEVSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 16:18:14 -0500
Date: Thu, 5 Feb 2004 22:17:56 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>
Cc: Tomas Zvala <tomas@zvala.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0, cdrom still showing directories after being erased
Message-ID: <20040205211756.GD1541@elf.ucw.cz>
References: <20040203131837.GF3967@aurora.fi.muni.cz> <Pine.LNX.4.53.0402030839380.31203@chaos> <401FB78A.5010902@zvala.cz> <20040203152805.GI11683@suse.de> <20040205182335.GB294@elf.ucw.cz> <20040205204109.GD11683@suse.de> <20040205210907.GB1541@elf.ucw.cz> <20040205211212.GG11683@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205211212.GG11683@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Okay, we may be dealing with the buggy hardware at this point. Would
> > it make sense to tell the drive to flush it caches? If there's no
> > other possibility, we might want cdrecord to reset drive at the end of
> > blank and/or to make it eject...
> 
> Just have cdrecord eject the disc, it's pretty common. Resetting the
> drive is a bit drastic, imho.

It is less drastic than having user close the tray... (Many notebook
drives can eject but need human to close).
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
