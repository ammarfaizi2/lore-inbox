Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316715AbSGLRfp>; Fri, 12 Jul 2002 13:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316723AbSGLRfo>; Fri, 12 Jul 2002 13:35:44 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:12020 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S316715AbSGLRfm>; Fri, 12 Jul 2002 13:35:42 -0400
Date: Fri, 12 Jul 2002 11:36:49 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: kwijibo@zianet.com
Cc: Dax Kelson <dax@gurulabs.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020712173649.GN8738@clusterfs.com>
Mail-Followup-To: kwijibo@zianet.com, Dax Kelson <dax@gurulabs.com>,
	linux-kernel@vger.kernel.org
References: <1026490866.5316.41.camel@thud> <20020712170532.GI8738@clusterfs.com> <3D2F1158.6060608@zianet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D2F1158.6060608@zianet.com>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 12, 2002  11:26 -0600, kwijibo@zianet.com wrote:
> I compared reiserfs with notails and with tails to
> ext3 in journaled mode about a month ago.
> Strangely enough the machine that was being
> built is eventually slated for a mail machine.  I used
> postmark to simulate the mail environment.
> 
> Benchmarks are available here:
> http://labs.zianet.com
> 
> Let me know if I am missing any info on there.

Yes, I saw this benchmark when it was first posted.  It isn't clear
from the web pages that you are using data=journal for ext3.  Note
that this is only a benefit for sync I/O workloads like mail and
NFS, but not other types of usage.  Also, for sync I/O workloads
you can get a big boost by using an external journal device.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

