Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVGLLsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVGLLsJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 07:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVGLLpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 07:45:46 -0400
Received: from [203.171.93.254] ([203.171.93.254]:26512 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261346AbVGLLnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 07:43:31 -0400
Subject: Re: [PATCH] [5/48] Suspend2 2.1.9.8 for 2.6.12:
	350-workthreads.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050712112542.GM1854@elf.ucw.cz>
References: <11206164393426@foobar.com> <112061643920@foobar.com>
	 <20050710230441.GC513@infradead.org> <1121150400.13869.22.camel@localhost>
	 <20050712105754.GA23947@elf.ucw.cz> <1121166456.13869.165.camel@localhost>
	 <20050712111516.GL1854@elf.ucw.cz> <1121167515.13869.168.camel@localhost>
	 <20050712112542.GM1854@elf.ucw.cz>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121168712.13869.171.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 12 Jul 2005 21:45:12 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2005-07-12 at 21:25, Pavel Machek wrote:
> > > OTOH: this is only critical for "niceness", not for
> > > correctness. Calling sync() before suspend is simply nice thing to do,
> > > but it is not required in any way. If someone is doing long dd, tough,
> > > they are going to loose some data if wakeup fails. It is no worse than
> > > sudden poweroff.
> > 
> > How can you say it's only required for niceness one minute, then admit
> > it might result in data loss the next?
> 
> It will result in data loss *if resume fails*. But failing resume
> *always* causes data in running programs to be lost, so I do not see
> that as a problem.

It does for you :>

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

