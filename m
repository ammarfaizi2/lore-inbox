Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267425AbTALTil>; Sun, 12 Jan 2003 14:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267427AbTALTil>; Sun, 12 Jan 2003 14:38:41 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12293 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267425AbTALTgz>; Sun, 12 Jan 2003 14:36:55 -0500
Date: Sun, 12 Jan 2003 11:41:03 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jaroslav Kysela <perex@suse.cz>
cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Adam Belay <ambx1@neo.rr.com>
Subject: Re: [PATCH] PnP update - drivers
In-Reply-To: <Pine.LNX.4.33.0301122025520.611-100000@pnote.perex-int.cz>
Message-ID: <Pine.LNX.4.44.0301121139450.14031-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 12 Jan 2003, Jaroslav Kysela wrote:
>
> You can import this changeset into BK by piping this whole message to:
> '| bk receive [path to repository]' or apply the patch as usual.

STOP THIS F*CKING MADNESS ALREADY.

If you send BK patches, at least do it right, and make sure your BK patch 
is a proper child of something I actually _have_, so that I don't get 
results like:

	takepatch: can't find parent ID
	        perex@suse.cz|ChangeSet|20030111100546|48939
	        in RESYNC/SCCS/s.ChangeSet

and if you only want to send the patch and not use BK merges, then don't 
even bother to _use_ the BK merge stuff.

		Linus

