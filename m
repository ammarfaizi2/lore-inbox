Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWIHJLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWIHJLY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 05:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWIHJLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 05:11:24 -0400
Received: from jaguar.mkp.net ([192.139.46.146]:35280 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S1750735AbWIHJLX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 05:11:23 -0400
To: Greg KH <greg@kroah.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, Fernando Vazquez <fernando@oss.ntt.co.jp>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       stable@kernel.org, "David S. Miller" <davem@davemloft.net>,
       devel@openvz.org, xemul@openvz.org
Subject: Re: [stable] [PATCH] IA64,sparc: local DoS with corrupted ELFs
References: <44FC193C.4080205@openvz.org>
	<Pine.LNX.4.64.0609061120430.27779@g5.osdl.org>
	<20060906182733.GJ2558@parisc-linux.org>
	<20060906184509.GA15942@kroah.com>
	<20060906191215.GK2558@parisc-linux.org>
	<20060906192511.GA14579@kroah.com>
From: Jes Sorensen <jes@sgi.com>
Date: 08 Sep 2006 05:11:21 -0400
In-Reply-To: <20060906192511.GA14579@kroah.com>
Message-ID: <yq0pse6hgee.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Greg" == Greg KH <greg@kroah.com> writes:

Greg> On Wed, Sep 06, 2006 at 01:12:16PM -0600, Matthew Wilcox wrote:
>> What's the easiest way to get coverage here?  Sending a parisc
>> workstation or server to someone?  Giving accounts to some/all of
>> the stable team?  Finding someone who cares about parisc to join
>> the stable team?

Greg> How about: Someone from that arch trying out the -stable release
Greg> canidates to make sure it doesn't break anything on their arches
Greg> / favorite machine?

I'll try and see if we can arrange some sort of autotest of these on
Altix, that should at least cover parts of the ia64 space.

Greg> And no, I really don't want a parisc machine here :)

What, you don't fancy 512 CPU Altix in your basement either? :)

Cheers,
Jes
