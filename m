Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVCCKpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVCCKpV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 05:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVCCKoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 05:44:38 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:10201 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261573AbVCCKn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:43:58 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "David S. Miller" <davem@davemloft.net>
Date: Thu, 3 Mar 2005 21:43:35 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16934.59991.693197.513163@cse.unsw.edu.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
In-Reply-To: message from David S. Miller on Wednesday March 2
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	<42264F6C.8030508@pobox.com>
	<20050302162312.06e22e70.akpm@osdl.org>
	<42265A6F.8030609@pobox.com>
	<20050302165830.0a74b85c.davem@davemloft.net>
	<422674A4.9080209@pobox.com>
	<Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
	<42268749.4010504@pobox.com>
	<20050302200214.3e4f0015.davem@davemloft.net>
	<42268F93.6060504@pobox.com>
	<4226969E.5020101@pobox.com>
	<20050302205826.523b9144.davem@davemloft.net>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday March 2, davem@davemloft.net wrote:
> On Wed, 02 Mar 2005 23:46:22 -0500 Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> > If Linus/DaveM really don't like -pre/-rc naming, I think 2.6.x.y is 
> > preferable to even/odd.
> 
> All of these arguments are circular.  If people think that even/odd
> will devalue odd releases, guess what 2.6.x.y will do?  By that line
> of reasoning nobody will test 2.6.x just the same as they aren't
> testing 2.6.x-rc* right now.

I think there is a qualitative difference.
2.6.x is the end of a line that 2.6.x-rc* leads up to.  There is a
clear end.  "I will test when it gets to the end".

2.6.x.y doesn't.  If the releases are quick (daily if there is
anything to release) then there is no clear end to the list, just a
beginning.  There may never be a 2.6.x.1 for some values of x, so
people won't be able to wait for the .1 or the .2 release.  They will
have to just take what is available when they want to upgrade.

If we want to stop people from waiting for a final release before they
test, we need to make sure there isn't a (recognisable in advance)
final release.

NeilBrown
