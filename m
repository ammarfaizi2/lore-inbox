Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132496AbRAaByX>; Tue, 30 Jan 2001 20:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132349AbRAaByN>; Tue, 30 Jan 2001 20:54:13 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:60946 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S132876AbRAaBx5>; Tue, 30 Jan 2001 20:53:57 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Date: Wed, 31 Jan 2001 12:53:42 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14967.28710.785746.261548@notabene.cse.unsw.edu.au>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] Linux 2.2.18 nfs v3 server bug (was: Incompatible: FreeBSD 4.2 client, Linux 2.2.18 nfsv3 server, read-only export)
In-Reply-To: message from Matthias Andree on Thursday January 25
In-Reply-To: <20010123015612.H345@quadrajet.flashcom.com>
	<20010123162930.B5443@emma1.emma.line.org>
	<wuofwynsj5.fsf_-_@bg.sics.se>
	<20010123105350.B344@quadrajet.flashcom.com>
	<20010124041437.A28212@emma1.emma.line.org>
	<14958.28927.756597.940445@notabene.cse.unsw.edu.au>
	<20010124142002.A1405@emma1.emma.line.org>
	<20010125012918.A15282@emma1.emma.line.org>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday January 25, matthias.andree@stud.uni-dortmund.de wrote:
> On Wed, 24 Jan 2001, Matthias Andree wrote:
> 
> > This looks better and it makes FreeBSD able to ls the directory, and on
> > touch /mnt/try, I get EROFS on the client, so this is okay; however, the
> > access reply does not include EXECUTE permissions which I find strange,
> > since the client lists this:
> > 
> 
> My fault. NFSv3 has a different permission partitioning than local file
> systems have, I did not see that. So Linux does the right
> thing for ACCESS with Neil's patch. Neil, could you submit that patch to
> Alan or bless it for inclusion into 2.2.19(pre)? The FreeBSD people
> could then sleep well again. :-)

I have sent bunch of patches to Alan some weeks ago, but no 2.2.19pre
release has appeared since.  When the 2.2.19pre series gets going
again, I will certainly sent this patch, and a few others that I have
collected.

NeilBrown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
