Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270805AbTHFRHn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 13:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270806AbTHFRHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 13:07:43 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:37627 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S270805AbTHFRGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 13:06:55 -0400
Date: Wed, 6 Aug 2003 11:06:34 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Jan Niehusmann <jan@gondor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uncorrectable ext2 errors
Message-ID: <20030806110634.G7752@schatzie.adilger.int>
Mail-Followup-To: Jan Niehusmann <jan@gondor.com>,
	linux-kernel@vger.kernel.org
References: <20030806150335.GA5430@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030806150335.GA5430@gondor.com>; from jan@gondor.com on Wed, Aug 06, 2003 at 05:03:35PM +0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 06, 2003  17:03 +0200, Jan Niehusmann wrote:
> A few days ago, I reported some problems with a ext2 filesystem which I
> cannot repair with e2fsck. Now I got some new observations.
> 
> To summarize the problem: e2fsck reports block bitmap differences, but
> telling it to repair these doesn't help, another e2fsck run reports the
> same differences.

Is this the root filesystem that is being checked?  If yes, then you
probably need to either reboot after the fsck is complete (before
mounting RW), or run the fsck from a rescue disk/CD.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

