Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbVF0Qha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbVF0Qha (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 12:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbVF0PAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 11:00:49 -0400
Received: from smtpout3.uol.com.br ([200.221.4.194]:23505 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S261203AbVF0N5z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 09:57:55 -0400
Date: Sun, 26 Jun 2005 23:50:59 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Problems with Firewire and -mm kernels (was: Re: 2.6.12-mm2)
Message-ID: <20050627025059.GC10920@ime.usp.br>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050626040329.3849cf68.akpm@osdl.org> <42BE99C3.9080307@trex.wsi.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050626040329.3849cf68.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew.

I am experiencing problems with -mm kernels and my firewire HD. I can use
it without any problems with Linus's 2.6.12, but I had problems with both
-mm1 and -mm2 (I just compiled -mm2 to see if the problem would go away,
but it didn't).

I am using the same .config file for all compiles, except that I wanted to
use the -mm tree for some things that I think would be orthogonal to the
issue (like using FUSE, for example).

I can't provide more details now, but as soon as I go to work with the
machine that presented the problem, I can give you all the details.

Essentially, what happens with -mm kernels that don't happen with Linus's
kernel is that the sbp2 module gets loaded, but it seems that the subsystem
never gets to actually see the partitions of the HD (I am using a HFS+
formatted disk for transfers of data between Linux and MacOS X).

If others also have the problem, I would like to know about it.

The Firewire controller that I am using is a vanilla VIA card and the HD is
a Seagate PATA HD in a Firewire enclosure (it's a ADS Tech DLX-185, if I am
not mistaken).

As I said, I can provide further details if wanted/needed.


Thanks for your work, Rogério.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
