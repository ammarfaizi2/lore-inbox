Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281273AbRKMAT6>; Mon, 12 Nov 2001 19:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281284AbRKMATs>; Mon, 12 Nov 2001 19:19:48 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:35317 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281273AbRKMATn>;
	Mon, 12 Nov 2001 19:19:43 -0500
Date: Mon, 12 Nov 2001 17:17:05 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Steve Lord <lord@sgi.com>, Ben Israel <ben@genesis-one.com>,
        linux-kernel@vger.kernel.org,
        "Peter J . Braam" <braam@clusterfilesystem.COM>
Subject: Re: File System Performance
Message-ID: <20011112171705.Z1778@lynx.no>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Steve Lord <lord@sgi.com>, Ben Israel <ben@genesis-one.com>,
	linux-kernel@vger.kernel.org,
	"Peter J . Braam" <braam@inter-mezzo.org>
In-Reply-To: <3BF02702.34C21E75@zip.com.au>, <00b201c16b81$9d7aaba0$5101a8c0@pbc.adelphia.net> <3BEFF9D1.3CC01AB3@zip.com.au> <00da01c16ba2$96aeda00$5101a8c0@pbc.adelphia.net> <3BF02702.34C21E75@zip.com.au> <1005595583.13307.5.camel@jen.americas.sgi.com> <3BF03402.87D44589@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3BF03402.87D44589@zip.com.au>; from akpm@zip.com.au on Mon, Nov 12, 2001 at 12:41:38PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 12, 2001  12:41 -0800, Andrew Morton wrote:
> BTW, I've been trying to hunt down a suitable file system aging tool.
> We're not very happy with Keith Smith's workload because the directory
> infomation was lost (he was purely studying FFS algorithmic differences
> - the load isn't 100% suitable for testing other filesystems / algorithms).
>   Constantin Loizides' tools are proving to be rather complex to compile,
>   drive and understand.

What _may_ be a very interesting tool for doing "real-world" I/O generation
is to use the InterMezzo KML (kernel modification log), which is basically
a 100% record of every filesystem operation done (e.g. create, write,
delete, mkdir, rmdir, etc).

Peter, do you have any very large KML files which would simulate the usage
of a filesystem over a long period of time, or would Tacitus have something
like that?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

