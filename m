Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbWHHNz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbWHHNz3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 09:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbWHHNz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 09:55:29 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:490 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932587AbWHHNz2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 09:55:28 -0400
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: Edgar Toernig <froese@gmx.de>, Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       akpm@osdl.org, viro@zeniv.linux.org.uk, tytso@mit.edu,
       tigran@veritas.com
In-Reply-To: <20060808125747.GB5284@ucw.cz>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	 <20060805122936.GC5417@ucw.cz> <20060807101745.61f21826.froese@gmx.de>
	 <84144f020608070251j2e14e909v8a18f62db85ff3d4@mail.gmail.com>
	 <20060807224144.3bb64ac4.froese@gmx.de>
	 <1155040157.5729.34.camel@localhost.localdomain>
	 <20060808125747.GB5284@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Aug 2006 15:14:56 +0100
Message-Id: <1155046496.5729.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-08 am 12:57 +0000, ysgrifennodd Pavel Machek:
> > To use revoke() I must own the file
> > If I own the file I can make it a symlink to a pty/tty pair
> > I can revoke a pty/tty pair
> 
> How can you symlink opened file?

I make a symlink before running the app which opens it. Or if the app
doesn't open it I pass the file handle of a pty/tty pair to it.

Alan

