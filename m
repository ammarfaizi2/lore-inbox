Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129358AbRBTBiY>; Mon, 19 Feb 2001 20:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbRBTBiO>; Mon, 19 Feb 2001 20:38:14 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:44807 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129358AbRBTBiA>; Mon, 19 Feb 2001 20:38:00 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 20 Feb 2001 12:37:42 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14993.51814.34672.957715@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: problems with reiserfs + nfs using 2.4.2-pre4
In-Reply-To: message from Alan Cox on Tuesday February 20
In-Reply-To: <14993.48376.203279.390285@notabene.cse.unsw.edu.au>
	<E14V1Xa-0005Bf-00@the-village.bc.nu>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday February 20, alan@lxorguk.ukuu.org.uk wrote:
> >  This may seem like a lot, but several of these are already
> >  requirements which most filesystems don't meet, and other are there
> >  to tidy-up interfaces and make locking more straight forward.
> 
> As a 2.5 thing it sounds like a very sensible path. It will also provide
> some of the operations groundwork needed for file systems that can only use
> NFS4 temporary handles

I had wanted to get it in before 2.4, but didn't quite make it.

I guess that means that, from your perspective, nfs exporting of
reiserfs remains an extra-kernel patch at least until 2.5 starts up
and the code has been tested extensively and it gets backported to
2.4, or maybe even until 2.6/3.0.  Such is life.

NeilBrown
