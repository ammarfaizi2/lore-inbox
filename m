Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030337AbVKPNvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbVKPNvW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 08:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030336AbVKPNvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 08:51:22 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:20639 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1030337AbVKPNvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 08:51:22 -0500
Date: Wed, 16 Nov 2005 14:51:16 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, alex14641@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051116135116.GA24753@wohnheim.fh-wedel.de>
References: <20051116005034.73421.qmail@web50210.mail.yahoo.com> <1132128212.2834.17.camel@laptopd505.fenrus.org> <20051116111812.4a1ea18a.grundig@teleline.es> <1132137638.2834.29.camel@laptopd505.fenrus.org> <p73oe4kpx6n.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <p73oe4kpx6n.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 November 2005 13:57:36 +0100, Andi Kleen wrote:
> 
> I think it's in general risky. It's like balancing without a safety
> net.  Might be a nice hobby, but for real production you want a safety
> net.  That's simple because there are likely some code paths through
> the code that need more stack space and that are rarely hit (and
> cannot be easily found by static analysis, e.g. if they involve
> indirect pointers or particularly complex configuration setups).

It isn't that hard to find such places.  Trouble is that you find so
many of them and it takes quite a while to go through them all.  Years
is a good unit for "quite a while".

Jörn

-- 
With a PC, I always felt limited by the software available. On Unix, 
I am limited only by my knowledge.
-- Peter J. Schoenster
