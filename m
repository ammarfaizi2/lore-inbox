Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267480AbTAGSq4>; Tue, 7 Jan 2003 13:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267494AbTAGSq4>; Tue, 7 Jan 2003 13:46:56 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:49396 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S267480AbTAGSqC>; Tue, 7 Jan 2003 13:46:02 -0500
Date: Tue, 7 Jan 2003 11:53:57 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: John Bradford <john@grabjohn.com>
Cc: root@chaos.analogic.com, maxvaldez@yahoo.com, bulb@ucw.cz,
       linux-kernel@vger.kernel.org
Subject: Re: Virtual WORM device
Message-ID: <20030107115357.V31555@schatzie.adilger.int>
Mail-Followup-To: John Bradford <john@grabjohn.com>,
	root@chaos.analogic.com, maxvaldez@yahoo.com, bulb@ucw.cz,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.3.95.1030107131613.3523A-100000@chaos.analogic.com> <200301071841.h07If7QJ002323@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301071841.h07If7QJ002323@darkstar.example.net>; from john@grabjohn.com on Tue, Jan 07, 2003 at 06:41:07PM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 07, 2003  18:41 +0000, John Bradford wrote:
> > Somebody should then modify `rm` and the kernel unlink
> > to `mv' files to the dumpster directory on the
> > file-system, instead of really deleting them.
> 
> Another possibility would be to create a meta-device that works like a
> cross between the loopback device, and WORM device, I.E. start at the
> begining, and allocate sectors sequentially.  Whenever a sector would
> normally be overwritten, a new one is allocated instead.  This way,
> you could always access the filesystem as it was at any mount in time.

This is commonly called a filesystem snapshot, and you can already do
it with LVM.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

