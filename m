Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262565AbVCDLCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262565AbVCDLCG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 06:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbVCDLCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 06:02:06 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:475 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S262565AbVCDLBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 06:01:54 -0500
Subject: Re: RFD: Kernel release numbering
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, greg@kroah.com, torvalds@osdl.org,
       davem@davemloft.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050303213454.50e2f584.akpm@osdl.org>
References: <42268749.4010504@pobox.com>
	 <20050302200214.3e4f0015.davem@davemloft.net> <42268F93.6060504@pobox.com>
	 <4226969E.5020101@pobox.com> <20050302205826.523b9144.davem@davemloft.net>
	 <4226C235.1070609@pobox.com> <20050303080459.GA29235@kroah.com>
	 <4226CA7E.4090905@pobox.com>
	 <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
	 <422751C1.7030607@pobox.com> <20050303181122.GB12103@kroah.com>
	 <20050303151752.00527ae7.akpm@osdl.org>
	 <1109894511.21781.73.camel@localhost.localdomain>
	 <20050303182820.46bd07a5.akpm@osdl.org> <4227CE58.6020607@pobox.com>
	 <20050303213454.50e2f584.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1109933992.26799.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 04 Mar 2005 10:59:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-03-04 at 05:34, Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> This means that for patches which didn't come through -mm, their first
> exposure in a public tree will be when they pop up in our "most stable"
> tree.  That's backwards.

Its irrelevant. Most of the "must fix" items are security. They don't
have a convenient testing life cycle. Many of the others are things that
need a prompt fix and the same problem applies.

After all if it was in -mm then someone knew about it and would have
said "this has to make base before its released"

> However it should be manageable, as long as linux-release is constrained to
> obviously-correct and its-no-more-broken-now-than-it-used-to-be patches. 

And occasionally it will be wrong. It happens. Linus released 2.4.15,
I've released -ac patches and stuff that needed immediate "oh duh, try
the next one"
results. The important thing is that there is a base 'stable' release
that is almost always stable. That is as good as you'll get.

Alan

