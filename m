Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266127AbUGJEOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266127AbUGJEOk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 00:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266128AbUGJEOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 00:14:40 -0400
Received: from vivaldi.madbase.net ([81.173.6.10]:13266 "HELO
	vivaldi.madbase.net") by vger.kernel.org with SMTP id S266127AbUGJEOj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 00:14:39 -0400
Date: Sat, 10 Jul 2004 00:14:35 -0400 (EDT)
From: Eric Lammerts <eric@lammerts.org>
X-X-Sender: eric@vivaldi.madbase.net
To: Martin Ziegler <mz@newyorkcity.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: NFS no longer working ?
In-Reply-To: <8232A615C6D0B05C09DBF242@soho>
Message-ID: <Pine.LNX.4.58.0407100008020.19087@vivaldi.madbase.net>
References: <8232A615C6D0B05C09DBF242@soho>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 9 Jul 2004, Martin Ziegler wrote:
> just installed kernel version 2.6.7 on RedHat 8.0. Unfortunately i'm no
> longer able to use NFS. Are there any recent issues ? For a detailed
> problem description please see below. Any help is appreciated.

I also had problems with NFS on 2.6.x (not the same as yours, though).
The solution was to do "mount -t nfsd none /proc/fs/nfsd" on the
server. You might wanna give that a try, maybe it'll help.

Eric
