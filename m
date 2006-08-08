Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932582AbWHHM6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbWHHM6J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 08:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbWHHM6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 08:58:08 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60676 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932457AbWHHM6F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 08:58:05 -0400
Date: Tue, 8 Aug 2006 12:57:47 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Edgar Toernig <froese@gmx.de>, Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       akpm@osdl.org, viro@zeniv.linux.org.uk, tytso@mit.edu,
       tigran@veritas.com
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
Message-ID: <20060808125747.GB5284@ucw.cz>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI> <20060805122936.GC5417@ucw.cz> <20060807101745.61f21826.froese@gmx.de> <84144f020608070251j2e14e909v8a18f62db85ff3d4@mail.gmail.com> <20060807224144.3bb64ac4.froese@gmx.de> <1155040157.5729.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155040157.5729.34.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > it works for regular files and even goes as far as destroying
> > all mappings of the file from all processes (even root processes).
> > IMVHO this is a disaster from a security and reliability point
> > of view.
> 
> Actually its no different than if it didn't. The two are identical
> behaviours.
> 
> To use revoke() I must own the file
> If I own the file I can make it a symlink to a pty/tty pair
> I can revoke a pty/tty pair

How can you symlink opened file?

-- 
Thanks for all the (sleeping) penguins.
