Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbVKVJZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbVKVJZM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 04:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbVKVJZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 04:25:12 -0500
Received: from mail.gmx.de ([213.165.64.20]:16845 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751290AbVKVJZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 04:25:10 -0500
X-Authenticated: #428038
Date: Tue, 22 Nov 2005 10:25:07 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
Message-ID: <20051122092507.GE16295@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <11b141710511210144h666d2edfi@mail.gmail.com> <200511211252.04217.rob@landley.net> <1132603369.3306.1.camel@gimli.at.home> <200511212342.47379.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511212342.47379.rob@landley.net>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2005, Rob Landley wrote:

> 2^64 we may actually live to see the end of someday, but it's not guaranteed.  
> 2^128 becoming relevant in our lifetimes is a touch unlikely.

Some people suggested we don't know usage and organization patterns yet,
perhaps something that is very sparse can benefit from linear addressing
in a huge (not to say vastly oversized) address space. Perhaps not.

One real-world example is that we've been doing RAM overcommit for a
long time to account for but not actually perform memory allocations,
and on 32-bit machines, 1 GB of RAM already required highmem until
recently. So here, 64-bit address space comes as an advantage.

-- 
Matthias Andree
