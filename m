Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281020AbRKGVsI>; Wed, 7 Nov 2001 16:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280954AbRKGVqj>; Wed, 7 Nov 2001 16:46:39 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:47867 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S280980AbRKGVqL>;
	Wed, 7 Nov 2001 16:46:11 -0500
Date: Wed, 7 Nov 2001 14:45:55 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Ville Herva <vherva@niksula.hut.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 vs resizerfs vs xfs
Message-ID: <20011107144555.N5922@lynx.no>
Mail-Followup-To: Ville Herva <vherva@niksula.hut.fi>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E161UYR-0004S5-00@the-village.bc.nu> <E161Vbf-0000m9-00@lilac.csi.cam.ac.uk> <20011107213837.F26218@niksula.cs.hut.fi> <E161ZYW-0006ky-00@mauve.csi.cam.ac.uk> <20011107141157.L5922@lynx.no> <20011107233731.N1504@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011107233731.N1504@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Wed, Nov 07, 2001 at 11:37:31PM +0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 07, 2001  23:37 +0200, Ville Herva wrote:
> On Wed, Nov 07, 2001 at 02:11:57PM -0700, [Andreas Dilger] said:
> > If you have an open but unlinked file, then ext3 will delete this file at
> > mount/fsck time (unlike reiserfs which leaves it around wasting space).
> 
> Is this really still true for reiserfs? Is there a way to get rid of them?
> reiserfsck? I had this vague impression that this bug had been dealt with

It may be fixed by now, but it wasn't for a long time.  I'm not sure what
reiserfs patches are in the stock kernel anymore.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

