Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271351AbTHDA4A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 20:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271352AbTHDA4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 20:56:00 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:55992 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S271351AbTHDAz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 20:55:59 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Chip Salzenberg <chip@pobox.com>
Date: Mon, 4 Aug 2003 10:55:44 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16173.44816.973033.11872@gargle.gargle.HOWL>
Cc: Steve Dickson <SteveD@redhat.com>, nfs@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: nfs-utils-1.0.5 is not backwards compatible with 2.4
In-Reply-To: message from Chip Salzenberg on Friday August 1
References: <3F294DE3.9020304@RedHat.com>
	<16169.54918.472349.928145@gargle.gargle.HOWL>
	<20030801143807.GB24358@perlsupport.com>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday August 1, chip@pobox.com wrote:
> According to Neil Brown:
> > I don't know if there is any such code, but if there is I apoligize for
> > breaking it and suggest that the best fix is to not use the header
> > file it was using but it explicitly include the values for NFSEXP_* in
> > that code.
> 
> The only really bad thing about the current situation is that the name
> "NFSEXP_CROSSMNT" is poisoned by having had two historical
> definitions.  So it that name should be dropped, IMO, and replaced by
> something textually different.  "NFSEXP_XMOUNT", perhaps.  Even
> "NFSEXP_CROSSMNT2" would work.  Just as long as code that said
> "CROSSMNT" to mean "NOHIDE" wouldn't accidentally get CROSSMNT instead.

If we were to change it,  I would prefer  NFSEXP_CROSSMOUNT.

I might send such a patch to Linus and update nfs-utils if/when it
gets included (or should 2.6 patches start going to Andrew now??)

NeilBrown
