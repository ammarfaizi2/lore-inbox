Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264837AbSJPDaw>; Tue, 15 Oct 2002 23:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264839AbSJPDaw>; Tue, 15 Oct 2002 23:30:52 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:31370 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S264837AbSJPDav>; Tue, 15 Oct 2002 23:30:51 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Stephan von Krawczynski <skraw@ithnet.com>
Date: Wed, 16 Oct 2002 13:36:34 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15788.57026.234504.747098@notabene.cse.unsw.edu.au>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: nfs-server slowdown in 2.4.20-pre10 with client 2.2.19
In-Reply-To: message from Stephan von Krawczynski on Tuesday October 15
References: <20021013172138.0e394d96.skraw@ithnet.com>
	<15785.64463.490494.526616@notabene.cse.unsw.edu.au>
	<20021014045410.4721c209.skraw@ithnet.com>
	<15786.15416.668502.225074@notabene.cse.unsw.edu.au>
	<20021015194538.10f54ef3.skraw@ithnet.com>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday October 15, skraw@ithnet.com wrote:
> On Mon, 14 Oct 2002 13:38:32 +1000
> Neil Brown <neilb@cse.unsw.edu.au> wrote:
> 
> Hello Neil,
> hello Trond,
> 
> > This night I will try to reduce rsize/wsize from the current 8192 down to
> > 1024 as suggested by Jeff.
> 
> Ok. The result is: it is again way slower. I was not even capable to transfer 5
> GB within 18 hours, that's when I shot the thing down.
> Anything else I can test?

All I can suggest is a binary search among the patches that comprise
the difference between pre9 and pre10 to see when the problem comes
in.

There are about 40 patches, so about 6 test runs  should find the
culprit.

I tried to extract them from bk and have put the 40 patches at:

  http://www.cse.unsw.edu.au/~neilb/pre10/

There is a p-all.tgz  that contains them all.

NeilBrown
