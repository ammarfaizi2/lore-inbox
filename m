Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265112AbSJaCdz>; Wed, 30 Oct 2002 21:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265113AbSJaCdz>; Wed, 30 Oct 2002 21:33:55 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:27043 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S265112AbSJaCdx>; Wed, 30 Oct 2002 21:33:53 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Date: Thu, 31 Oct 2002 13:40:09 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15808.38921.992361.527623@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.45
In-Reply-To: message from Udo A. Steinberg on Thursday October 31
References: <Pine.LNX.4.44.0210301651120.6719-100000@penguin.transmeta.com>
	<20021031022218.2cb81b2e.us15@os.inf.tu-dresden.de>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday October 31, us15@os.inf.tu-dresden.de wrote:
> On Wed, 30 Oct 2002 16:56:29 -0800 (PST) Linus Torvalds (LT) wrote:
> 
> LT> Summary of changes from v2.5.44 to v2.5.45
> LT> ============================================
> 
> [...]
> 
> fs/nfsd/nfs4proc.c: In function `nfsd4_write':
> fs/nfsd/nfs4proc.c:484: warning: passing arg 4 of `nfsd_write' from incompatible pointer type
> fs/nfsd/nfs4proc.c:484: warning: passing arg 6 of `nfsd_write' makes integer from pointer without a cast
> fs/nfsd/nfs4proc.c:484: too few arguments to function `nfsd_write'
> fs/nfsd/nfs4proc.c: In function `nfsd4_proc_compound':
> fs/nfsd/nfs4proc.c:568: structure has no member named `rq_resbuf'
> fs/nfsd/nfs4proc.c:569: structure has no member named `rq_resbuf'
> fs/nfsd/nfs4proc.c:569: structure has no member named `rq_resbuf'
> make[3]: *** [fs/nfsd/nfs4proc.o] Error 1
> 

Yes. 

   http://linux.bkbits.com:8080/linux-2.5/cset@1.844.1.75

I did NFSv2 and NFSv3 which are similar.  NFSv4 is quite different
code so I wanted to leave it for a separate patch (which isn't done yet).

NeilBrown
