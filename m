Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751516AbWIFTSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbWIFTSx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 15:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWIFTSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 15:18:52 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:51376 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751501AbWIFTSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 15:18:51 -0400
Date: Wed, 6 Sep 2006 12:17:40 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Matthew Wilcox <matthew@wil.cx>
cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, Fernando Vazquez <fernando@oss.ntt.co.jp>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       stable@kernel.org, "David S. Miller" <davem@davemloft.net>,
       devel@openvz.org, xemul@openvz.org
Subject: Re: [stable] [PATCH] IA64,sparc: local DoS with corrupted ELFs
In-Reply-To: <20060906191215.GK2558@parisc-linux.org>
Message-ID: <Pine.LNX.4.64.0609061214430.11553@schroedinger.engr.sgi.com>
References: <44FC193C.4080205@openvz.org> <Pine.LNX.4.64.0609061120430.27779@g5.osdl.org>
 <20060906182733.GJ2558@parisc-linux.org> <20060906184509.GA15942@kroah.com>
 <20060906191215.GK2558@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Sep 2006, Matthew Wilcox wrote:

> What's the easiest way to get coverage here?  Sending a parisc
> workstation or server to someone?  Giving accounts to some/all of the
> stable team?  Finding someone who cares about parisc to join the stable
> team?

Follow the conventional patch: Send patch to Andrew for mm inclusion so 
that we can all test it and then get it into Linus' tree?

2.6.17.x is used neither by Suse nor by Redhat. For Suse exposure you may 
have to get it into 2.6.16.x.

