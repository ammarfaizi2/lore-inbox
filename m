Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262386AbUKDVma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbUKDVma (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 16:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbUKDVma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 16:42:30 -0500
Received: from mirador.placard.fr.eu.org ([81.56.186.204]:12038 "EHLO
	mail.placard.fr.eu.org") by vger.kernel.org with ESMTP
	id S262386AbUKDVm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 16:42:26 -0500
To: Stelian Pop <stelian@popies.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: meye bug? (was: meye driver update)
Mail-Copies-To: never
X-Face: ,MPrV]g0IX5D7rgJol{*%.pQltD?!TFg(`c8(2pkt-F0SLh(g3mIFYU1GYf]C/GuUTbr;cZ5y;3ALK%.OL8A.^.PW14e/,X-B?Nv}2a9\u-j0sSa
References: <20041104111231.GF3472@crusoe.alcove-fr>
	<87zn1xjoqo.fsf@mirexpress.internal.placard.fr.eu.org>
From: Roland Mas <roland.mas@free.fr>
Date: Thu, 04 Nov 2004 22:42:24 +0100
In-Reply-To: <87zn1xjoqo.fsf@mirexpress.internal.placard.fr.eu.org> (Roland
 Mas's message of "Thu, 04 Nov 2004 22:19:59 +0100")
Message-ID: <87654ljnpb.fsf@mirexpress.internal.placard.fr.eu.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Mas, 2004-11-04 22:19:59 +0100 :

>   I'd like to take the opportunity to report a bug with meye.  I've
> ran various 2.6.* kernels on this recently acquired laptop,
> including 2.6.10-rc1 with your patches, all that with a Debian
> system on it (Sarge/testing).

Reading myself again, I realise this may not be very clear, sorry.
The bug happens with all versions of 2.6.* I've tried, including
2.6.10-rc1 + your patches.

I did some more testing with other userspace apps.

- With vgrabbj 0.9.3-1:
$ vgrabbj -d /dev/video0 foo.jpeg
Problem getting window information
Fatal Error (non-daemon), exiting...
There was no map allocated to be freed...
$
(And no complaint from kernel).

- With motion 3.1.14-2:
$ motion
Processing thread 0 - config file motion.conf
Thread0 device: /dev/video0 input: 8
[Nothing happens for a while, then I get bored and ^C]
$
(And exactly one "meye: need to reset HIC!" message).

Roland.
-- 
Roland Mas

Despite rumour, Death isn't cruel - merely terribly, terribly good at his job.
  -- in Sourcery (Terry Pratchett)
