Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760287AbWLFIBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760287AbWLFIBO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 03:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760291AbWLFIBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 03:01:14 -0500
Received: from wylie.me.uk ([82.68.155.89]:41641 "EHLO mail.wylie.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760287AbWLFIBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 03:01:12 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17782.30913.566538.135240@wylie.me.uk>
Date: Wed, 6 Dec 2006 08:01:05 +0000
To: linux-kernel@vger.kernel.org
From: alan@wylie.me.uk (Alan J. Wylie)
Newsgroups: linux.kernel
Subject: Re: can't boot : Spurious ACK with kernel 2.6.19
References: <20061205225316.GA2948@mail.prager.ws>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 06 Dec 2006 00:00:13 +0100, Bernd Prager <bernd@prager.ws> said:

> I'm trying to upgrade to kernel 1.6.19.  The boot process immediatly
> locks in a loop with the message: "atkbd.c: Spurious ACK on
> isa0060/serio0. Some program might be trying access hardware
> directly."

The above message is a result of the keyboard LEDs being flashed after
a failed boot.

See my posting
http://lkml.org/lkml/2006/12/5/239
with a patch to suppress these repeated messages, so you can see what
the real problem is.

-- 
Alan J. Wylie                                          http://www.wylie.me.uk/
"Perfection [in design] is achieved not when there is nothing left to add,
but rather when there is nothing left to take away."
  -- Antoine de Saint-Exupery
