Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316309AbSFUGV2>; Fri, 21 Jun 2002 02:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316322AbSFUGV1>; Fri, 21 Jun 2002 02:21:27 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:18898 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S316309AbSFUGV0>; Fri, 21 Jun 2002 02:21:26 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: r.ems@gmx.net
Date: Fri, 21 Jun 2002 16:22:12 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15634.50708.164289.246414@notabene.cse.unsw.edu.au>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Hubert Mantel <mantel@suse.de>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: kernel OOPS: 2.4.18, nscd, nfsd
In-Reply-To: message from Richard Ems on Wednesday June 19
References: <3D104DF4.A8053F67@gmx.net>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday June 19, r.ems.home@gmx.net wrote:
> Hi all!
> 
> Two kernel Oopses in short time (22:35:59 and 22:50:00). But the computer was still alive until 00:00:00, where the daily cron jobs are started and then ... kernel panic, LED's where blinking   :(
> 
> kernel is 2.4.18, from SuSE's k_deflt-2.4.18-174 package (2.4.19-pre10aa2)
> 
> Please CC to r.ems@gmx.net, I'm not on the linux-kernel mailing
> list.

Would I be right is surmising that you are exporting an ISO filesystem
over NFS??  That would be the second Oops in as many days with that
scenario.

If that is the case, then I'm afraid that I cannot point you to any
fix, though exporting with "no_subtree_check" may reduce the incidence.

NeilBrown

