Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbUBUCHU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 21:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbUBUCHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 21:07:20 -0500
Received: from palrel13.hp.com ([156.153.255.238]:47079 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261477AbUBUCHM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 21:07:12 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16438.48457.641361.533828@napali.hpl.hp.com>
Date: Fri, 20 Feb 2004 18:07:05 -0800
To: Jes Sorensen <jes@wildopensource.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Bill Davidsen <davidsen@tmr.com>,
       David Mosberger-Tang <David.Mosberger@acm.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Intel x86-64 support merge
In-Reply-To: <yq0vfm2ry2x.fsf@wildopensource.com>
References: <1qK5k-7g2-67@gated-at.bofh.it>
	<1qK5k-7g2-69@gated-at.bofh.it>
	<1qK5k-7g2-71@gated-at.bofh.it>
	<1qK5k-7g2-73@gated-at.bofh.it>
	<1qK5k-7g2-65@gated-at.bofh.it>
	<40353382.8010505@tmr.com>
	<40358AC5.90103@pobox.com>
	<yq0vfm2ry2x.fsf@wildopensource.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 20 Feb 2004 02:48:06 -0500, Jes Sorensen <jes@wildopensource.com> said:

  Jeff> I doubt Win64 bounces for 64-bit PCI hardware, but who knows...

  Jes> Just a shame they don't seem to care about performance and allowing
  Jes> one to issue SAC cycles when possible.

Careful.  You're assuming that the I/O MMU translation is free.
Depending on many details, that may or may not be the case.

The timing couldn't have been better:

 http://marc.theaimsgroup.com/?l=linux-ia64&m=107732581008944

  Jes> Oh well, guess one just has to buy a real computer.

That's always a good idea.

	--david
