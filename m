Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264205AbUFFWzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264205AbUFFWzV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 18:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264211AbUFFWzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 18:55:21 -0400
Received: from mail012.syd.optusnet.com.au ([211.29.132.66]:32671 "EHLO
	mail012.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264205AbUFFWzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 18:55:17 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
Subject: Re: [PATCH] Staircase Scheduler v6.3 for 2.6.7-rc2
Date: Mon, 7 Jun 2004 08:55:00 +1000
User-Agent: KMail/1.6.1
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       William Lee Irwin III <wli@holomorphy.com>
References: <200406070139.38433.kernel@kolivas.org> <40C381D7.5030406@gmx.de>
In-Reply-To: <40C381D7.5030406@gmx.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406070855.00648.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2004 06:43, Prakash K. Cheemplavam wrote:
> Hi,

Hi. Thanks for testing.

> it is the first time I tried this scheduler with 2.6.7-rc2-mm2. A k.o
> criteria for me: Playing ut2004 it generated a lot of statics (sound
> wise). I consider this a regression in contrast to O(1). Nick's
> scheduler plays nice as well. For Nick's I have X reniced to -10. Your
> scheduler doesn't like this, as well: When plaing some tune via xmms and
> then switching to another (virtual) desktop, I get pops in the sound for
> fractions of a second. Putting X back to 0 fixes this. But I don't know
> how to "fix" ut2004 with staircase. :-(

Yes this is designed for X nice==0.

Try interactive = 0 setting for gaming.

Con
