Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbTH2T7v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 15:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbTH2T5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 15:57:36 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:452
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261757AbTH2Tzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 15:55:45 -0400
Date: Fri, 29 Aug 2003 21:55:43 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Shantanu Goel <sgoel01@yahoo.com>
Cc: Antonio Vargas <wind@cocodriloo.com>, linux-kernel@vger.kernel.org,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: [VM PATCH] Faster reclamation of dirty pages and unused inode/dcache entries in 2.4.22
Message-ID: <20030829195543.GD24409@dualathlon.random>
References: <20030829192844.GB24409@dualathlon.random> <20030829194636.33817.qmail@web12807.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030829194636.33817.qmail@web12807.mail.yahoo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 12:46:36PM -0700, Shantanu Goel wrote:
> Andrea,
> 
> I'll test and submit a patch against -aa.  Also, is
> there a common benchmark that you use to test for
> regression?

bonnie,tiobench,dbench would be a very good start for the basics (note:
dbench can be misleading, but at the same fariness levels, it's
interesting too, it's just that dbench doesn't measure the fariness
level itself [like tiobench started doing relatively recently]).

(I'm assuming the patch makes difference not only for mmapped dirty
pages, in such case the above would be non interesting)

thanks,

Andrea
