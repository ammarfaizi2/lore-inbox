Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272145AbTHICOQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 22:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272156AbTHICOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 22:14:16 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:8472 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272145AbTHICOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 22:14:16 -0400
Date: Sat, 9 Aug 2003 03:13:22 +0100
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6test /proc/net/pnp oops.
Message-ID: <20030809021317.GF16007@suse.de>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20030809011901.GA16007@suse.de> <20030808184950.3b2bd6e2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030808184950.3b2bd6e2.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 08, 2003 at 06:49:50PM -0700, Andrew Morton wrote:

 > >  Unable to handle kernel paging request at virtual address c06f977c
 > Could you please check your System.map and verify that ic_servaddr was at
 > 0xc06f977c?

-ENOSYSTEMMAP
Though your patch does seem to make sense (to me at least).
I'll give it a try.  I certainly haven't configured anything, so it
seems to be showing random junk which resolves to various random
bits of the internet. Groovy. Only seems to happen on one box though.

		Dave

