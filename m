Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932627AbWCIMfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627AbWCIMfm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 07:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbWCIMfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 07:35:42 -0500
Received: from AMarseille-252-1-96-117.w86-202.abo.wanadoo.fr ([86.202.151.117]:58840
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S932627AbWCIMfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 07:35:40 -0500
To: ink@jurassic.park.msu.ru (Ivan Kokshaysky)
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
       Christoph Hellwig <hch@lst.de>, Richard Henderson <rth@twiddle.net>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Problem on Alpha with "convert to generic irq framework"
References: <20060304111219.GA10532@localhost>
	<20060306155114.A8425@jurassic.park.msu.ru>
	<20060306135434.GA12829@localhost>
	<20060306191324.A1502@jurassic.park.msu.ru>
	<20060306163142.GA19833@localhost>
	<20060308142857.A4851@jurassic.park.msu.ru>
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
From: Mathieu Chouquet-Stringer <ml2news@free.fr>
Organization: Uh?
Date: 09 Mar 2006 13:34:56 +0100
In-Reply-To: <20060308142857.A4851@jurassic.park.msu.ru>
Message-ID: <m3d5gvn6dr.fsf@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ink@jurassic.park.msu.ru (Ivan Kokshaysky) writes:
> Well, the problem with the new interrupt code is that it does
> local_irq_enable() before return from interrupt.
> [...]

Your patch works wonder, thanks Ivan.

-- 
Mathieu Chouquet-Stringer
