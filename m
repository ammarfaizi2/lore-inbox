Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267974AbRHBBq1>; Wed, 1 Aug 2001 21:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268571AbRHBBqR>; Wed, 1 Aug 2001 21:46:17 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:13029 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S268562AbRHBBqG>; Wed, 1 Aug 2001 21:46:06 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: nbecker@fred.net
Date: Thu, 2 Aug 2001 11:46:05 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15208.45277.787888.292427@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: re-export nfs possible?
In-Reply-To: message from nbecker@fred.net on  August 1
In-Reply-To: <m3wv4nmei0.fsf@nbecker.fred.net>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  August 1, nbecker@fred.net wrote:
> Is it possible to mount a fs via nfs, and then reexport it via nfs?

No.

The protocol doesn't really support it, and the (Linux-kernel)
implementation definately doesn't support it.

I think the user-space nfs server can do it.  It has other problems,
but it might work for you.

NeilBrown
