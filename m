Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbTJGOam (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 10:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbTJGOam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 10:30:42 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:39161 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S262269AbTJGOak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 10:30:40 -0400
Date: Tue, 7 Oct 2003 08:29:44 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: "E. Gryaznova" <grev@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can dbench be used for benchmarking fs?
Message-ID: <20031007082944.D1564@schatzie.adilger.int>
Mail-Followup-To: "E. Gryaznova" <grev@namesys.com>,
	linux-kernel@vger.kernel.org
References: <3F82B4C6.707221A@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F82B4C6.707221A@namesys.com>; from grev@namesys.com on Tue, Oct 07, 2003 at 04:42:46PM +0400
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 07, 2003  16:42 +0400, E. Gryaznova wrote:
> I use dbench for benchmarking the file systems and some results are
> suspicious for me.
> :
> :
> :
> As the result: the measuring deviation is equal = 23.4062 - 15.7005 =
> 7.7057 or about ~38% from average value.
> 
> So, I have 2 questions :
> 1. Is there a way to avoid such big deviations on measuring a file
> systems throughput and to get more stable results?
> 2. Can dbench be used for benchmarking the file systems and if it is so
> -- what is the predictable error on the measuring?

Dbench is not a good filesystem benchmark, because it deletes all of the
files at the end.  Use something else for the filesystem benchmark - there
are lots of them (bonnie, iozone, mongo, etc).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

