Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbTENBLx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 21:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbTENBLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 21:11:52 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:35017 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S261939AbTENBLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 21:11:51 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Date: Wed, 14 May 2003 11:24:34 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16065.39634.214317.736721@notabene.cse.unsw.edu.au>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.69-bk8: sunrpc
In-Reply-To: message from Felipe Alfaro Solana on  May 14
References: <1052866301.588.1.camel@teapot.felipe-alfaro.com>
X-Mailer: VM 7.15 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  May 14, felipe_alfaro@linuxmail.org wrote:
> I saw the following oops just after compiling 2.5.69-bk8 and booting it
> up. It happened while booting Red Hat Linux 9. Data copied by hand...
> 
> EIP:    0060:[<e08d1ece>]   Not tainted
> EFLAGS: 00010246
> EIP is at svc_sock_update_bufs+0x74/0x17d [sunrpc]

Are you able to
   echo disassemble svc_sock_update_bufs | gdb -batch -x /dev/stdin  net/sunrpc/sunrpc.o 

and send me the output?

Thanks,
NeilBrown
