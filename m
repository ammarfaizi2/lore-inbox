Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264208AbTGKQhZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 12:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264219AbTGKQhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 12:37:25 -0400
Received: from air-2.osdl.org ([65.172.181.6]:31202 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264208AbTGKQhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 12:37:24 -0400
Date: Fri, 11 Jul 2003 09:52:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Lars Marowsky-Bree <lmb@suse.de>
cc: Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.75
In-Reply-To: <20030711102728.GE24023@marowsky-bree.de>
Message-ID: <Pine.LNX.4.44.0307110948100.3452-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 11 Jul 2003, Lars Marowsky-Bree wrote:
> 
> We'd like to avoid that nightmare for 2.6 though, so we definetely
> care.

Hey, all the better. However, in that case I'd strongly suggest up the
management chain that people be aware of the fact that if they want 2.6.x
to be stable on anything but x86, it will need testing. Both internally
and externally. By doing things like running all the internal machines on 
a pre-2.6 kernel.

The same is true of x86 too, but there at least there will be test 
coverage even without vendor support. Vendors making their own internal 
distributions with pre-2.6 kernels will help on x86 too, of course. Hint 
hint.

(Late 2.3.x got much better coverage through things like this, so I'm not 
all that pessimistic. But people need to be aware of the issue).

		Linus

