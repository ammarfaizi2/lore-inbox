Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318092AbSG2XAn>; Mon, 29 Jul 2002 19:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318095AbSG2XAm>; Mon, 29 Jul 2002 19:00:42 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:10697 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S318092AbSG2XAm>; Mon, 29 Jul 2002 19:00:42 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 30 Jul 2002 09:04:19 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15685.51699.423140.374908@notabene.cse.unsw.edu.au>
Cc: Jan Hudec <bulb@ucw.cz>, linux-fsdevel@sd3.mailbank.com,
       linux-kernel@vger.kernel.org, "Peter J. Braam" <braam@clusterfs.com>
Subject: Re: Race in open(O_CREAT|O_EXCL) and network filesystem
In-Reply-To: message from Andreas Dilger on Monday July 29
References: <20020728165256.GA4631@vagabond>
	<15685.11287.43065.570783@notabene.cse.unsw.edu.au>
	<20020729150211.GC3077@clusterfs.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday July 29, adilger@clusterfs.com wrote:
> 
> The intent-based lookup code is available as part of the Lustre CVS.
> See lustre/patches/patch-2.4.18 at the SF lustre project.  There are
> a couple of other changes in the patch that are unrelated to intents,
> but those are fairly obvious (i.e. ext3/jbd changes, some exports, etc).
> 

Thanks.  I've found it.  I might have a read through some time.
Is there any plan (or likelyhood) for this getting into 2.5?

NeilBrown
