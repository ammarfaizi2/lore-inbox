Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbVKUV6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbVKUV6K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbVKUV6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:58:10 -0500
Received: from cantor.suse.de ([195.135.220.2]:17557 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751104AbVKUV6J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:58:09 -0500
From: Neil Brown <neilb@suse.de>
To: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Date: Tue, 22 Nov 2005 08:58:02 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17282.17130.991367.308610@cse.unsw.edu.au>
Cc: Lars Roland <lroland@gmail.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Poor Software RAID-0 performance with 2.6.14.2
In-Reply-To: message from Lennart Sorensen on Monday November 21
References: <4ad99e050511211231o97d5d7fw59b44527dc25dcea@mail.gmail.com>
	<20051121204752.GK9488@csclub.uwaterloo.ca>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday November 21, lsorense@csclub.uwaterloo.ca wrote:
> On Mon, Nov 21, 2005 at 09:31:14PM +0100, Lars Roland wrote:
> > I have created a stripe across two 500Gb disks located on separate IDE
> > channels using:
> > 
> > mdadm -Cv /dev/md0 -c32 -n2 -l0 /dev/hdb /dev/hdd
> 
> Does -l0 equal stripe or linear?  The mdadm man page doesn't seem clear
> o that to me.

0 is raid0.  I thought that was so blatantly obvious that it wasn't
worth spelling it out in the man page.  Maybe I was wrong :-(.

NeilBrown
