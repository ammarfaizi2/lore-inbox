Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267597AbTBLUBv>; Wed, 12 Feb 2003 15:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267605AbTBLUBv>; Wed, 12 Feb 2003 15:01:51 -0500
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:18937 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id <S267597AbTBLUBu>; Wed, 12 Feb 2003 15:01:50 -0500
Date: Wed, 12 Feb 2003 13:11:09 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Eric Chen <echen@ateonix.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: changing file copy to support extended attributes
Message-ID: <20030212131109.M22930@schatzie.adilger.int>
Mail-Followup-To: Eric Chen <echen@ateonix.com>,
	linux-kernel@vger.kernel.org
References: <NFBBIGILIDAABCBKKGMLAECOCCAA.echen@ateonix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <NFBBIGILIDAABCBKKGMLAECOCCAA.echen@ateonix.com>; from echen@ateonix.com on Wed, Feb 12, 2003 at 11:35:11AM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 12, 2003  11:35 -0800, Eric Chen wrote:
> I wanted to modify file copy so it supports extended attributes. I am using
> extended attributes provided by the XFS filesystem, and right now when I
> copy a file with an extended attribute bit set on, the copy of the file does
> not preserve the extended attribute. I could use some help in this area
> because I am not sure where to start. If anyone has some suggestions or can
> offer me some help or resources to go to, please let me know.

Probably only user-space changes are needed.  I think there are already
modified tools for this.  See http://acl.bestbits.at.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

