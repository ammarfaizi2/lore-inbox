Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263059AbUE2D3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbUE2D3k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 23:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUE2D3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 23:29:40 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:23511 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261425AbUE2D3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 23:29:38 -0400
Date: Fri, 28 May 2004 10:32:34 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Chris Shoemaker <c.shoemaker@cox.net>,
       Mark Watts <m.watts@eris.qinetiq.com>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: ftp.kernel.org
Message-ID: <20040528163234.GV2603@schnapps.adilger.int>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Chris Shoemaker <c.shoemaker@cox.net>,
	Mark Watts <m.watts@eris.qinetiq.com>,
	Linux Kernel Mail List <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.33.0405280018250.14297-100000@sweetums.bluetronic.net> <200405280941.38784.m.watts@eris.qinetiq.com> <20040528062141.GA18118@cox.net> <20040528150119.GE18449@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040528150119.GE18449@thunk.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 28, 2004  11:01 -0400, Theodore Ts'o wrote:
> On Fri, May 28, 2004 at 02:21:41AM -0400, Chris Shoemaker wrote:
> > > Agreed - fmirror is so much more reliable than rsync (imho) that it makes 
> > > rsync into a worst-case option for retrieving files.
> > 
> >   bug reports to rsync@lists.samba.org are appreciated...
> > 
> 
> The main problem with rsync that I can see is that it is fairly heavy
> weight on the server, so many servers (including mirrors.kernel.org)
> have a maximum number of connections set to something pathetically
> small, like say 5 connections.  
> 
> I remember Tridge trying to get someone to implement checksum caching
> for rsync servers some 4+ years ago, which would surely help.  Did
> that ever get done?  If so, convincing the server admins that it's OK
> to up the maximum number of rsync connections would be the next step.

Ideally we would move to something like http/ftp-meets-bittorrent for content
replication.  Then sites which are popular would have lots of mirrors by
default, and dedicated FTP mirror sites would actually share bandwidth ala
bittorrent instead of just having copies of the same data.  If this started
using users' web browser cache as bittorrent mirrors it would be totally
impossible to slashdot a site.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

