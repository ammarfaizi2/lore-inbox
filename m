Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317298AbSGVNng>; Mon, 22 Jul 2002 09:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317360AbSGVNnf>; Mon, 22 Jul 2002 09:43:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52242 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317298AbSGVNnW>; Mon, 22 Jul 2002 09:43:22 -0400
Date: Mon, 22 Jul 2002 14:46:26 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@transmeta.com>,
       Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [patch] cli()/sti() cleanup, 2.5.27-A2
Message-ID: <20020722144626.D2838@flint.arm.linux.org.uk>
References: <20020722152056.A18619@lst.de> <Pine.LNX.4.44.0207221538580.9004-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207221538580.9004-100000@localhost.localdomain>; from mingo@elte.hu on Mon, Jul 22, 2002 at 03:43:50PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 03:43:50PM +0200, Ingo Molnar wrote:
> i'm not so sure about flags_t. 'unsigned long' worked pretty well so far,
> and i do not see the need for a more complex (or more opaque) irqflags
> type.

A feature request then.  Type checking.  Too many people try to stuff
the value into an int or signed long.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

