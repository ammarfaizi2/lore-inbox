Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265877AbUFISGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265877AbUFISGA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 14:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265883AbUFISF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 14:05:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35237 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265877AbUFISEi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 14:04:38 -0400
Date: Wed, 9 Jun 2004 15:05:14 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Chris Johns <cbjohns@mn.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kswapd excessive CPU time
Message-ID: <20040609180514.GA5859@logos.cnet>
References: <510EDE3E-B962-11D8-B170-000A958E2366@mn.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <510EDE3E-B962-11D8-B170-000A958E2366@mn.rr.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2004 at 10:41:32AM -0500, Chris Johns wrote:
> On a 2.4.21 kernel (kernel.org + KDB patch + MITRE security patches),
> I've seen bizarre (I think) behavior from kswapd.
> 
> My question boils down to this: given the (simple) scenario below,
> am I missing critical VM/kswapd patches, or is this behavior
> expected and OK, or is it wrong and possibly fixed in the 2.6 kernel?
> Or is the kswapd behavior somehow tunable to avoid the apparent
> thrashing that I saw? 

Recent 2.4 VM should fix this, but you better of use 2.6.
