Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280456AbRKNLE6>; Wed, 14 Nov 2001 06:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280457AbRKNLEt>; Wed, 14 Nov 2001 06:04:49 -0500
Received: from mustard.heime.net ([194.234.65.222]:41346 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S280456AbRKNLEc>; Wed, 14 Nov 2001 06:04:32 -0500
Date: Wed, 14 Nov 2001 12:04:29 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
cc: <linux-kernel@vger.kernel.org>, Andre Hedrick <andre@linux-ide.org>
Subject: Re: [PATCH] Re: linux readahead setting?
In-Reply-To: <200111140038.fAE0ctq11703@mailg.telia.com>
Message-ID: <Pine.LNX.4.30.0111141203560.5413-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Note that the interface to /proc/ide/hdX/settings still is buggy...
>
> i.e you should be able to do (in pages):
> echo "file_readahead:64" > /proc/ide/hdX/settings
> but the result will be a readahead of 128*1024 PAGES... and that
> is too much... (even 1024 PAGES is too much)
>
> (after patch, in kB)
> echo "file_readahead:256" > /proc/ide/hdX/settings
>
> It is likely that there are more settings in the ide subsystem that is
> has this fault... (Andre, I keep repeating myself...)

er...
I'm running Compaq RAID controllers... Not IDE...

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

