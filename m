Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129609AbQKMAKd>; Sun, 12 Nov 2000 19:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129483AbQKMAKX>; Sun, 12 Nov 2000 19:10:23 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:50695 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129178AbQKMAKP>; Sun, 12 Nov 2000 19:10:15 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andre Holzner <Andre.Holzner@cern.ch>
Date: Mon, 13 Nov 2000 11:10:00 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14863.12632.977079.624838@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: Q: nfs over tcp status ?
In-Reply-To: message from Andre Holzner on Sunday November 12
In-Reply-To: <3A0F161A.F5C60650@cern.ch>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(please remove linux-kernel from future followups)

On Sunday November 12, Andre.Holzner@cern.ch wrote:
> Hello,
> 
> (I hope this is not the wrong mailing list to ask this question..)

Not "wrong" exactly, but not "best" either.
Look in the MAINTAINERS file of a recent kernel source tree, look for
references to NFS, and see if any mailing lists are suggested.
You should find
   nfs@lists.sourceforge.net

> 
> Does somebody know what the status of the support of nfs
> via tcp (instead of udp) of Linux is ? Is there a version
> supporting this (client and server) ? Are there some
> plans to support this under Linux ?
> 

The client side support for nfs/tcp is all there in late 2.2.18
pre-patches, and patches for earlier kernels are available.  See
   http://nfs.sourceforge.net
for details.
Client side support is also in 2.4.0 test releases.

The server side is much less mature.  I believe that when 2.2.18 comes
out it will have nfs/tcp server as a 'experimental' compile time
options.  Much of the same code is in 2.4.0-testX, but I don't think
the compile time option is there, you need to edit the code to enable
it.

NeilBrown


> 
> best regards & many thanks,
> 
> 
> Andre
> 
> 
> -- 
> ------------------+----------------------------------
> Andre Holzner     | +41 22 76 76750 
> Bureau 32 2-C13   | Building 32     
> CERN              | Office 2-C13    
> CH-1211 Geneve 23 | http://wwweth.cern.ch/~holzner/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
