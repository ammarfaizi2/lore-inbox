Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313537AbSERR2y>; Sat, 18 May 2002 13:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSERR2x>; Sat, 18 May 2002 13:28:53 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:43506 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S313537AbSERR2w>; Sat, 18 May 2002 13:28:52 -0400
Date: Sat, 18 May 2002 11:26:34 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
Subject: Re: Htree directory index for Ext2, updated
Message-ID: <20020518172634.GK21295@turbolinux.com>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200205170736.g4H7aNj281162@saturn.cs.uml.edu> <E178x1B-0000DW-00@starship> <20020518055808.GH21295@turbolinux.com> <E178xSu-0000Dc-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 18, 2002  08:13 +0200, Daniel Phillips wrote:
> I cloned a repository that is arranged like:
> 
>   somedir
>     |
>     |--linux
>     |    |
>     |    The usual stuff
>     |
>      `---other things
> 
> Bitkeeper wants the destination for the import to be 'somedir', and
> cannot figure out how to apply a patch that looks like:
> +++ src/include/linux/someheader.h, for instance.

And that is bad in what way?  If you try to apply that patch from
'somedir' you expect patch/BK to have ESP to know it should apply
under 'linux'.  If 'patch' will apply such a diff, then it is just
a sign of the problems you were complaining about - that it uses
heuristics to guess which file to modify, and they are not 100% right.

Of course, if you are really talking about a patch, and not a BK
changeset, then the problem lies solely with 'patch' and 'diff'
and has nothing to do with BK at all.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

