Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbTKGXZj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 18:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbTKGXZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 18:25:32 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:45812 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263935AbTKGXZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 18:25:08 -0500
Date: Fri, 7 Nov 2003 18:13:59 -0500
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Maciej Zenczykowski <maze@cela.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: undo an mke2fs !!
Message-ID: <20031107231359.GA2722@pimlott.net>
Mail-Followup-To: Szakacsits Szabolcs <szaka@sienet.hu>,
	Maciej Zenczykowski <maze@cela.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0311061753350.21501-100000@gaia.cela.pl> <Pine.LNX.4.58.0311070601380.10194@ua178d119.elisa.omakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0311070601380.10194@ua178d119.elisa.omakaista.fi>
User-Agent: Mutt/1.3.28i
From: Andrew Pimlott <andrew@pimlott.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 07, 2003 at 06:35:03AM +0200, Szakacsits Szabolcs wrote:
> 	http://linux-ntfs.sourceforge.net/man/ntfsclone.html
> 
> It clones either all used data or only metadata to a mountable image at the
> sector level (so it's much more efficient than dd if disk is far away to be
> full).

Can it avoid seeking all over the place when copying the data?  This
would be really cool for fast backups and getting data off a dying
disk.

Andrew
