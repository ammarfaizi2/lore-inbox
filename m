Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264366AbUD0VhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264366AbUD0VhE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 17:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbUD0VhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 17:37:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10985 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264366AbUD0Vfu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 17:35:50 -0400
Date: Tue, 27 Apr 2004 22:35:49 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc2-bk3 (and earlier?) mount problem (?
Message-ID: <20040427213549.GC17014@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0404261758230.19703@ppc970.osdl.org> <20040427010748.GY17014@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0404271106500.22815@alpha.polcom.net> <1083070293.30344.116.camel@watt.suse.com> <Pine.LNX.4.58.0404271500210.27538@alpha.polcom.net> <20040427140533.GI14129@stingr.net> <20040427183410.GZ17014@parcelfarce.linux.theplanet.co.uk> <20040427200459.GJ14129@stingr.net> <20040427202813.GA17014@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0404272232030.9618@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404272232030.9618@alpha.polcom.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2004 at 10:39:09PM +0200, Grzegorz Kulewski wrote:
> > 	c) nobody sane should put that as default.  Oh, wait, it's gentoo
> > we are talking about?  Nevermind, then.
> 
> But what default? Gentoo just calls evms_activate before mounting 
> filesystems to check if there are evms volumes (because filesystems can 
> reside on it). And, according to man page, this is the right usage of 
> evms_activate.

And that usage of evms_activate takes over all normally partitioned devices
and shoves equivalents of partitions under /dev/evms, right?  So in which
universe would that be the right thing to do without a big fat warning and
update of /etc/fstab?
