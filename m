Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264710AbSJUDUq>; Sun, 20 Oct 2002 23:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264712AbSJUDUq>; Sun, 20 Oct 2002 23:20:46 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:3464 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S264710AbSJUDUl>; Sun, 20 Oct 2002 23:20:41 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: bert hubert <ahu@ds9a.nl>
Date: Mon, 21 Oct 2002 13:26:26 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15795.29666.121485.737045@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfsd/sunrpc boot on reboot in 2.5.44
In-Reply-To: message from bert hubert on Sunday October 20
References: <20021020173142.GA26384@outpost.ds9a.nl>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday October 20, ahu@ds9a.nl wrote:
> 
> By the way, can anybody tell me how to convert this:
> Oct 20 19:21:32 hubert kernel:  [<c8831060>] auth_domain_drop+0x50/0x60 [sunrpc]
> 
> To a line in auth_domain_drop()?
> 

 gdb sunrpc.o
 disassemble auth_domain_drop

 stare at assembler listing, stare at source code....

NeilBrown
