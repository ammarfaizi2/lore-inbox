Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262192AbVBVCSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbVBVCSS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 21:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbVBVCSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 21:18:18 -0500
Received: from mo01.iij4u.or.jp ([210.130.0.20]:3527 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S262192AbVBVCSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 21:18:15 -0500
Date: Tue, 22 Feb 2005 11:18:10 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Asier Llano Palacios <a.llano@usyscom.com>, jamey.hicks@hp.com
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org
Subject: Re: gpio api
Message-Id: <20050222111810.7f3f6e22.yuasa@hh.iij4u.or.jp>
In-Reply-To: <1108980144.15299.16.camel@localhost.localdomain>
References: <4215F1A0.1030805@hp.com>
	<1108980144.15299.16.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2005 11:02:24 +0100
Asier Llano Palacios <a.llano@usyscom.com> wrote:

> I think that implementing a GPIO interface is a must-have. And I also
> think that your proposal is awesome. I work with GPIOs a lot, and I hate
> not doing it in a cross-platform way.
> 
> I generally agree with your proposal but I see some missing behaviours.

me too,

> Configuration that should be done on GPIOs.
> - GPIO direction (input/output)
> - GPIO modes (standard CMOS / open drain).

I also need pull-up/pull-down.

> - GPIO interruption generation (by level or edge, high, low, raising,
> falling)

We also need a method that GPIO cascade to IRQ.

Yoichi
