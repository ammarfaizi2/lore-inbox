Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263383AbTIWSy4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 14:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263366AbTIWSy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 14:54:56 -0400
Received: from ns.suse.de ([195.135.220.2]:172 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263063AbTIWSyx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 14:54:53 -0400
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: "Luck, Tony" <tony.luck@intel.com>, "David S. Miller" <davem@redhat.com>,
       davidm@hpl.hp.com, davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au,
       ak@suse.de, iod00d@hp.com, peterc@gelato.unsw.edu.au,
       linux-ns83820@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
References: <DD755978BA8283409FB0087C39132BD101B01194@fmsmsx404.fm.intel.com>
	<20030923142925.A16490@kvack.org>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Leona, I want to CONFESS things to you..
 I want to WRAP you in a SCARLET ROBE trimmed with POLYVINYL CHLORIDE..
 I want to EMPTY your ASHTRAYS...
Date: Tue, 23 Sep 2003 20:54:50 +0200
In-Reply-To: <20030923142925.A16490@kvack.org> (Benjamin LaHaise's message
 of "Tue, 23 Sep 2003 14:29:25 -0400")
Message-ID: <jehe3372th.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise <bcrl@kvack.org> writes:

> On Tue, Sep 23, 2003 at 11:21:35AM -0700, Luck, Tony wrote:
>> Looking at a couple of ia64 build servers here I see zero unaligned
>> access messages in the logs.
>
> ip options can still be an odd number of bytes.  Having itanic spew bogus 
> log messages is just plain wrong (yet another hardware issue pushed off on 
> software for no significant gain).

Unaligned access are a BUG.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
