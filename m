Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030656AbWHIKWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030656AbWHIKWV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 06:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030654AbWHIKWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 06:22:20 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:661 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030650AbWHIKWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 06:22:19 -0400
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Edgar Toernig <froese@gmx.de>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       akpm@osdl.org, viro@zeniv.linux.org.uk, tytso@mit.edu,
       tigran@veritas.com
In-Reply-To: <20060809104155.48ad3c77.froese@gmx.de>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	 <20060805122936.GC5417@ucw.cz> <20060807101745.61f21826.froese@gmx.de>
	 <84144f020608070251j2e14e909v8a18f62db85ff3d4@mail.gmail.com>
	 <20060807224144.3bb64ac4.froese@gmx.de>
	 <1155040157.5729.34.camel@localhost.localdomain>
	 <20060809104155.48ad3c77.froese@gmx.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 09 Aug 2006 11:42:07 +0100
Message-Id: <1155120128.5729.143.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-09 am 10:41 +0200, ysgrifennodd Edgar Toernig:
> > If I own the file I can make it a symlink to a pty/tty pair
> > I can revoke a pty/tty pair
> 
> With the EIO/EOF behaviour that's not a problem - apps that deal
> with ttys have to expect that condition.

Think about it a moment - I can symlink any file to a tty/pty pair so
any file I own you open might be a tty.

> Hmm... which apps have an open fd on block devices?  Usually a

cdrecord, cd audio players, eject, ....


