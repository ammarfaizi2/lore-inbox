Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267498AbTAGSsn>; Tue, 7 Jan 2003 13:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267499AbTAGSsm>; Tue, 7 Jan 2003 13:48:42 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:51188 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S267498AbTAGSsO>; Tue, 7 Jan 2003 13:48:14 -0500
Date: Tue, 7 Jan 2003 11:56:31 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: John Bradford <john@grabjohn.com>
Cc: Max Valdez <maxvaldez@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Undelete files on ext3 ??
Message-ID: <20030107115631.X31555@schatzie.adilger.int>
Mail-Followup-To: John Bradford <john@grabjohn.com>,
	Max Valdez <maxvaldez@yahoo.com>, linux-kernel@vger.kernel.org
References: <1041961118.13635.10.camel@garaged.fis.unam.mx> <200301071757.h07HvU1l002172@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301071757.h07HvU1l002172@darkstar.example.net>; from john@grabjohn.com on Tue, Jan 07, 2003 at 05:57:29PM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 07, 2003  17:57 +0000, John Bradford wrote:
> Maybe it's not working because you need to flush the journal before
> the ext2 tool will see the inode as deleted.  Alternatively, if that
> is the case, perhaps by ignoring the data in the journal, the file
> would not appear to be deleted.

Neither - ext3 does things differently, and you cannot undelete files
from ext3.  Sorry.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

