Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265972AbUFOVyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265972AbUFOVyK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 17:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265981AbUFOVyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 17:54:10 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:28210 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265972AbUFOVyH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 17:54:07 -0400
Date: Tue, 15 Jun 2004 15:03:49 -0700
From: Paul Jackson <pj@sgi.com>
To: Matthias Schniedermeyer <ms@citd.de>
Cc: aoliva@redhat.com, cesarb@nitnet.com.br, linux-kernel@vger.kernel.org,
       viro@math.psu.edu
Subject: Re: [PATCH] O_NOATIME support
Message-Id: <20040615150349.352b9fb1.pj@sgi.com>
In-Reply-To: <20040615193205.GA25131@citd.de>
References: <20040612011129.GD1967@flower.home.cesarb.net>
	<orpt81sv1g.fsf@free.redhat.lsd.ic.unicamp.br>
	<20040614224006.GD1961@flower.home.cesarb.net>
	<orfz8wabng.fsf@free.redhat.lsd.ic.unicamp.br>
	<20040615193205.GA25131@citd.de>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias, replying to Alexandre:
> > But utimes updates the inode modification time, so you can still tell
> > something happened to the file.
> 
> No.

A less terse answer:

  Utimes modifies the inode ctime - time of last inode change.

So, yes, you can still something happened to the file.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
