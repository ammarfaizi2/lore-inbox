Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbTCBWU2>; Sun, 2 Mar 2003 17:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbTCBWU2>; Sun, 2 Mar 2003 17:20:28 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:64988 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S261855AbTCBWU0>; Sun, 2 Mar 2003 17:20:26 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "H. Peter Anvin" <hpa@zytor.com>
Date: Mon, 3 Mar 2003 09:30:38 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15970.34318.504586.674652@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove DEVFS_FL_AUTO_DEVNUM
In-Reply-To: message from H. Peter Anvin on  March 2
References: <20030301190724.B1900@lst.de>
	<b3tor7$uqu$1@cesium.transmeta.com>
X-Mailer: VM 7.08 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  March 2, hpa@zytor.com wrote:
> Followup to:  <20030301190724.B1900@lst.de>
> By author:    Christoph Hellwig <hch@lst.de>
> In newsgroup: linux.dev.kernel
> > 
> > Rationale:  while dynamic major/minors are a good idea, devfs is the
> > wrong layer to do it because all code relying on it would break with
> > out devfs.
> > 
> 
> Your first clause here is a *highly* questionable statement...

Given the premise "Linus will not allow new static major/minors",
I think it is essential :-(

NeilBrown

> 
> 	-hpa
> -- 
> <hpa@transmeta.com> at work, <hpa@zytor.com> in private!
> "Unix gives you enough rope to shoot yourself in the foot."
> Architectures needed: cris ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
