Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318268AbSHMR1E>; Tue, 13 Aug 2002 13:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318254AbSHMR1D>; Tue, 13 Aug 2002 13:27:03 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:62202 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S318282AbSHMRZd>; Tue, 13 Aug 2002 13:25:33 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 13 Aug 2002 11:27:05 -0600
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT support in ext3?
Message-ID: <20020813172705.GG9642@clusterfs.com>
Mail-Followup-To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	Kernel mailing list <linux-kernel@vger.kernel.org>
References: <200208131548.36267.roy@karlsbakk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208131548.36267.roy@karlsbakk.net>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 13, 2002  15:48 +0200, Roy Sigurd Karlsbakk wrote:
> playing around with O_DIRECT, I really _can't_ make it work on ext3?
> 
> why is this?

Because O_DIRECT needs a specific o_direct I/O method that has not yet
been written for ext3.  I believe only ext2 and reiserfs support it
right now.  I will eventually need to add support for this, but it is
not yet high on my list of priorities.  Maybe someone else will beat
me to it.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

