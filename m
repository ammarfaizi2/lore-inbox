Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268207AbUIWSRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268207AbUIWSRl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 14:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268251AbUIWSR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 14:17:28 -0400
Received: from cantor.suse.de ([195.135.220.2]:38879 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268207AbUIWSP4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 14:15:56 -0400
Date: Thu, 23 Sep 2004 20:15:53 +0200
From: Andi Kleen <ak@suse.de>
To: Tigran Aivazian <tigran@veritas.com>
Cc: Thomas Zehetbauer <thomasz@hostmaster.org>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [discuss] Re: 2.6.8.1 doesn't boot on x86_64
Message-ID: <20040923181553.GB14114@wotan.suse.de>
References: <1095961031.3159.18.camel@hostmaster.org> <Pine.LNX.4.44.0409231843330.2275-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0409231843330.2275-100000@einstein.homenet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 06:44:46PM +0100, Tigran Aivazian wrote:
> On Thu, 23 Sep 2004, Thomas Zehetbauer wrote:
> 
> > Successfully running 2.6.8.1 on Tyan Thunder K8W/dual Opteron here.
> > 
> 
> Ok, thank you, but what would be even more interesting is if someone
> running Intel EM64T machine with ICH6 and 2 SATA disks on ata1 and nothing
> on ata2 also confirmed that 2.6.8.1-smp kernel works for them...

2.6.8.1 works fine for me on lots of different boxes.

Have you tried without the kdb patch? 

If not I would suggest to enable earlyprintk and see if you can
get better output.

-Andi
