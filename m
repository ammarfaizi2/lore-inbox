Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbVGLG1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVGLG1T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 02:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVGLG1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 02:27:18 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:51653 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261170AbVGLG1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 02:27:17 -0400
Subject: Re: [PATCH] [43/48] Suspend2 2.1.9.8 for 2.6.12:
	619-userspace-nofreeze.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050710231508.GI513@infradead.org>
References: <11206164393426@foobar.com> <1120616444351@foobar.com>
	 <20050710231508.GI513@infradead.org>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1121149739.13869.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 12 Jul 2005 16:29:00 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2005-07-11 at 09:15, Christoph Hellwig wrote:
> UI support is nothing that belongs here.  People won't die by having a text console for
> a while.

UI support belongs here for the following reasons:

- While driver support is imperfect, there is the potential for hangs.
People need to be able to recognise when this happens. They therefore
need some feedback to know that the process is not hung, and to be able
to say where it hung when it does.
- Particularly for the desktop, we want the system to look professional,
not half baked.
- Some support is needed for the user to be able to cancel a suspend.
You might not want to. Others might not want to, but this doesn't mean
that others shouldn't have the option of changing their minds.

I have already moved much of the code out to userspace in an effort to
ease your concerns. I'm not going so far as to remove the functionality,
though.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

