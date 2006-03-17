Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752487AbWCQDnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbWCQDnI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 22:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752492AbWCQDnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 22:43:07 -0500
Received: from mx1.suse.de ([195.135.220.2]:37090 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752487AbWCQDnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 22:43:06 -0500
From: Neil Brown <neilb@suse.de>
To: "Bret Towe" <magnade@gmail.com>
Date: Fri, 17 Mar 2006 14:41:49 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17434.12285.88843.708858@cse.unsw.edu.au>
Cc: "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs udp 1000/100baseT issue
In-Reply-To: message from Bret Towe on Thursday March 16
References: <dda83e780603151424u1b3ea605vd6e8dea896fc276e@mail.gmail.com>
	<Pine.LNX.4.61.0603162139450.11776@yvahk01.tjqt.qr>
	<dda83e780603161733o10a3c330kddf96a726f162fa7@mail.gmail.com>
	<17434.7434.626268.71114@cse.unsw.edu.au>
	<dda83e780603161911o7c2babb7wfc6671f9bc3441e4@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday March 16, magnade@gmail.com wrote:
> On 3/16/06, Neil Brown <neilb@suse.de> wrote:
> >
> > There is no flow control in UDP
> 
> is this a linux design flaw or just nature of udp?

Just the nature of UDP.

> >
> >   - use tcp
> 
> im wondering why this isnt the default to begin with

Because it wasn't that many years ago that Linux NFS didn't support
tcp at all.
Some distributions modify 'mount' to get it to prefer tcp over udp.

NeilBrown
