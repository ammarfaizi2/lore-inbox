Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279704AbRKAVoS>; Thu, 1 Nov 2001 16:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279802AbRKAVoI>; Thu, 1 Nov 2001 16:44:08 -0500
Received: from mustard.heime.net ([194.234.65.222]:59812 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S279704AbRKAVnu>; Thu, 1 Nov 2001 16:43:50 -0500
Date: Thu, 1 Nov 2001 22:43:37 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Padraig Brady <padraig@antefacto.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: writing a plugin for reiserfs compression
In-Reply-To: <3BE1C07D.5080205@antefacto.com>
Message-ID: <Pine.LNX.4.30.0111012242060.3245-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > But still... Are the files are compressed as they are created/modified on
> > the filesystem?
>
> Only if the file is in a directory with the +c attribute set.
> You can have full control over the compression.

Could this be modified to the 'wait <n> days' concept I mentioned earlier?
I mean... Don't let the kernel modify them - ever. Let some cron-job do
it...

> Note this transparent ext2 compression patch is only available for 2.2

Would it be hard to port to 2.4?

