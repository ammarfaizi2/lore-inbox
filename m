Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVD0SYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVD0SYt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 14:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbVD0SYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 14:24:49 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:9928 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261932AbVD0SYq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 14:24:46 -0400
Subject: Re: [01/07] uml: add nfsd syscall when nfsd is modular
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Wright <chrisw@osdl.org>
Cc: Greg KH <gregkh@suse.de>, blaisorblade@yahoo.it,
       user-mode-linux-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org
In-Reply-To: <20050427174652.GL23013@shell0.pdx.osdl.net>
References: <20050427171446.GA3195@kroah.com>
	 <20050427171552.GB3195@kroah.com>
	 <1114619612.18355.113.camel@localhost.localdomain>
	 <20050427174652.GL23013@shell0.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1114622596.18809.120.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 27 Apr 2005 18:23:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-04-27 at 18:46, Chris Wright wrote:
> > Don't see why this one is a critical bug.
> 
> I guess without it, modular nfsd has no syscall interface (for UML, or
> course).

And the trivial zero risk fix is to compile it in. Its hardly pressing

