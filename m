Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272057AbTHFXck (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 19:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269696AbTHFXbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 19:31:21 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:34206 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S275044AbTHFXbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 19:31:00 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: arjanv@redhat.com
Date: Thu, 7 Aug 2003 09:30:49 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16177.36777.849782.71565@gargle.gargle.HOWL>
Cc: Steve Dickson <SteveD@redhat.com>, nfs@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] [PATCH] kNFSd: Fixes a problem with inode clean up for
	vxfs
In-Reply-To: message from Arjan van de Ven on Wednesday August 6
References: <3F3128A4.8030305@RedHat.com>
	<1060187198.14950.0.camel@laptop.fenrus.com>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday August 6, arjanv@redhat.com wrote:
> On Wed, 2003-08-06 at 18:11, Steve Dickson wrote:
> > , vfat, ntfs
> 
> you can't NFS export vfat..... for lots of other reasons

Have you tried?

It is certainly not bullet-proof, but it works in simple cases (but
probably not in cases where the patch in question becomes an issue).

NeilBrown
