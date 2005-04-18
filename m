Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVDRGse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVDRGse (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 02:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbVDRGse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 02:48:34 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:1239 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261500AbVDRGsc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 02:48:32 -0400
X-ORBL: [67.124.119.21]
Date: Sun, 17 Apr 2005 23:48:10 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Chris Friesen <cfriesen@nortel.com>
Cc: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
Message-ID: <20050418064810.GD32315@taniwha.stupidest.org>
References: <4263275A.2020405@lab.ntt.co.jp> <20050418040718.GA31163@taniwha.stupidest.org> <4263356D.9080007@lab.ntt.co.jp> <20050418061221.GA32315@taniwha.stupidest.org> <42635518.6040704@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42635518.6040704@nortel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 12:35:04AM -0600, Chris Friesen wrote:

> In the telecom space it's quite common to want to modify multiple
> running binaries with as little downtime as possible.

OK

> (Beyond a threshold it becomes FCC-reportable in the US, and
> everyone wants to avoid that...)

That's beside the point.

> Our old proprietary OS had explicit support for replacing running
> binary code on the fly, so customers have gotten used to the
> ability.  Now they want equivalent functionality with our
> linux-based stuff.

*Why* do they need this is what I asked.  A sensible real world
example would be useful.

> For general application support I suspect some kernel support will
> be required.  Whether this is the way to go or whether it can be
> done using existing mechanisms, I'm not knowledgeable enough to
> comment.

I used to work in telco space, we had some such systems and similar
things.  Some from Nortel even.

None of the things I saw did anything that I can image really need a
complicated kernel patch for.


In fact, I'm not convinced *any* of these uses really needed
live-patching at all.


I would just like some examples of real-world needs and an explanation
of why it's needed.  Not handy-waving.
