Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264301AbUDSIgG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 04:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264304AbUDSIgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 04:36:06 -0400
Received: from ee.oulu.fi ([130.231.61.23]:42912 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S264301AbUDSIgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 04:36:04 -0400
Date: Mon, 19 Apr 2004 11:35:54 +0300 (EEST)
From: Tuukka Toivonen <tuukkat@ee.oulu.fi>
X-X-Sender: tuukkat@stekt37
To: danlee@informatik.uni-freiburg.de
cc: b-gruber@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: /dev/psaux-Interface
In-Reply-To: <Pine.GSO.4.58.0402271451420.11281@stekt37>
Message-ID: <Pine.GSO.4.58.0404191124220.21825@stekt37>
References: <Pine.GSO.4.58.0402271451420.11281@stekt37>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

psaux.c release 2004-04-19

This is psaux.c linux kernel driver for kernels 2.6.x,
a direct PS/2 serial port (aka /dev/psaux) driver.

Available from:
http://www.ee.oulu.fi/~tuukkat/rel/psaux-2004-04-19.tar.gz

(includes README with more information)

The driver was originally written by Lee Sau Dan
http://www.informatik.uni-freiburg.de/~danlee/fun/psaux/
but I fixed some bugs (most importantly SMP).

I've seen lots of discussions about different mouse behaviour (or
completely non-functioning mouse). If you have one of those problems, this
driver should restore the kernel 2.4.x behaviour.

Any suggestions/hopes to get it included into mainstream kernel?

P.S. is there any documentation about the serio interface (serio_open()
etc...)? I couldn't find anywhere.
