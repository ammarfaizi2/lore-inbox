Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289986AbSAPQbC>; Wed, 16 Jan 2002 11:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289991AbSAPQaw>; Wed, 16 Jan 2002 11:30:52 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:13297 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S289986AbSAPQam>;
	Wed, 16 Jan 2002 11:30:42 -0500
Date: Tue, 15 Jan 2002 21:16:35 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: "Henning P. Schmiedehausen" <hps@intermeta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Removing the whitespaces??? [Was: Re: Why not "attach" patches?]
Message-ID: <20020115211635.T11251@lynx.adilger.int>
Mail-Followup-To: "Henning P. Schmiedehausen" <hps@intermeta.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201151448050.5892-100000@xanadu.home> <Pine.LNX.4.33.0201151405250.9053-100000@segfault.osdlab.org> <20020115151629.N11251@lynx.adilger.int> <a22gfn$c15$1@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <a22gfn$c15$1@forge.intermeta.de>; from hps@intermeta.de on Wed, Jan 16, 2002 at 12:11:35AM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 16, 2002  00:11 +0000, Henning P. Schmiedehausen wrote:
> Andreas Dilger <adilger@turbolabs.com> writes:
> >Well, it would be a feature if it knew enough to only remove whitespace
> >at the end of "+" lines in context diffs.  Then we wouldn't have 200kB
> >of useless whitespace in the kernel sources.
> 
> (This is a TAB and a space in the square brackets above. 
> Don't use \s. Trust me.)
> 
> linux-2.2.20.tar.bz2:		15,751,285 bytes
> linux-2.2.20-nbl.tar.bz2:       15,608,085 bytes
> 
> Patch Size (uncompressed):	17,815,166 bytes (yes this _is_ 17,4 MBytes)
>            (compressed, bzip2):  3,322,456 bytes 
> 
> One mega-patch to shear off about 140 KBytes from the compressed (and
> about 170 k from the unpacked (94488 vs. 94316 KBytes ) kernel source
> would (while it may be the biggest single "reduce-size-of-kernel-tree
> patch" in years :-) ) a little gross.

Oh, I'm not advocating sending in a huge patch _just_ to remove the
useless whitespace (which includes trailing spaces/tabs and [space][tab]
combinations), but it would be nice if someone is setting up a patchbot
to remove such whitespace in new or modified lines in a patch.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

