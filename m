Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbTDMXdj (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 19:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262682AbTDMXdj (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 19:33:39 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:16118 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S262680AbTDMXdi (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 19:33:38 -0400
Date: Sun, 13 Apr 2003 17:38:10 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Lars Marowsky-Bree <lmb@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Benefits from computing physical IDE disk geometry?
Message-ID: <20030413173810.Z26054@schatzie.adilger.int>
Mail-Followup-To: Chuck Ebbert <76306.1226@compuserve.com>,
	Lars Marowsky-Bree <lmb@suse.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200304131817_MC3-1-3444-7E2F@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200304131817_MC3-1-3444-7E2F@compuserve.com>; from 76306.1226@compuserve.com on Sun, Apr 13, 2003 at 06:13:23PM -0400
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 13, 2003  18:13 -0400, Chuck Ebbert wrote:
> Lars Marowsky-Bree wrote:
> > Object Based Storage (see Lustre).
> 
>   Thanks, I was trying to remember where I'd seen that.
> 
>   Is anyone actually making such things for sale?

Yes, there is a 3rd party vendor which has already sold a bunch of
Object Storage Targets (OSTs) to LLNL for the MCR cluster, see:

	http://www.top500.org/top5/2002/11/five/
	http://www.llnl.gov/linux/mcr/
	http://www.bluearc.com/news/press_releases/pr_mcr_121102.shtml

These are not the "OST-on-a-disk" paradigm that we first worked on with
Seagate, but rather large NAS/NFS storage servers that also implement
the Lustre network protocol.  We are also working with other vendors to
implement Linux-based OST targets (I'm not sure whether I can reveal names
or not) for even larger clusters.

Maybe if Lustre becomes popular enough, we will see Lustre implemented on
single disks.  There is an object-based storage group with the SCSI T10
committee, but so far their protocol is mostly unusable for Lustre.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

