Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbTEHUbJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 16:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbTEHUbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 16:31:09 -0400
Received: from palrel10.hp.com ([156.153.255.245]:7587 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262112AbTEHUbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 16:31:06 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16058.49522.154858.334628@napali.hpl.hp.com>
Date: Thu, 8 May 2003 13:43:30 -0700
To: Christoph Hellwig <hch@lst.de>
Cc: torvalds@transmeta.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module_arch_cleanup()
In-Reply-To: <20030508184117.A26726@lst.de>
References: <20030508184117.A26726@lst.de>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 8 May 2003 18:41:17 +0200, Christoph Hellwig <hch@lst.de> said:

  Christoph> IA64 needs to be able to hook into module unloading to get rid of
  Christoph> the unwind tables for modules.  (The actual implementation already
  Christoph> is in arch/ia64/kernel/module.c, David just seems to be to shy to
  Christoph> submit core changes :))

Actually, I did submit it, even though it's Rusty's code.  See:

 http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=UTF-8&selm=20030409220021%242cec%40gated-at.bofh.it

Rusty wanted module_arch_cleanup() to be an unconditional thing.
Perhaps Linus disagreed and dropped it because of that.  I don't
really care.  Just make it work. ;-)

	--david
