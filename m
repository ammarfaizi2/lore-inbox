Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264543AbTKNFdQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 00:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264541AbTKNFdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 00:33:16 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:28591 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S264536AbTKNFdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 00:33:08 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: viro@parcelfarce.linux.theplanet.co.uk
Date: Fri, 14 Nov 2003 16:32:48 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16308.26880.297498.100662@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [RFCI] How best to partition MD/raid devices in 2.6
In-Reply-To: message from viro@parcelfarce.linux.theplanet.co.uk on Friday November 14
References: <16308.18387.142415.469027@notabene.cse.unsw.edu.au>
	<20031114050934.GI24159@parcelfarce.linux.theplanet.co.uk>
X-Mailer: VM 7.17 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday November 14, viro@parcelfarce.linux.theplanet.co.uk wrote:
> 

Thanks for the comments.

> (3) is absolutely trivial - will take 10--30 lines in md.c.

Yes.  I've actually started working on that (clear some stuff up first
so it become even more trivial).  I was feeling uncomfortable about
the non-uniform interpretation of minor numbers.  I know the block
layer can handle it.  I'm wondering what I should expect of users
though :-)

NeilBrown
