Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUE1OAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUE1OAV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 10:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbUE1OAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 10:00:20 -0400
Received: from ee.oulu.fi ([130.231.61.23]:19892 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S263138AbUE1N76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 09:59:58 -0400
Date: Fri, 28 May 2004 16:59:55 +0300 (EEST)
From: Tuukka Toivonen <tuukkat@ee.oulu.fi>
X-X-Sender: tuukkat@stekt37
To: Giuseppe Bilotta <bilotta78@hotpop.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
Message-ID: <Pine.GSO.4.58.0405281654370.3992@stekt37>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuseppe Bilotta wrote:
>The new system has some ups and downs. The biggest "down",
>which is that of RAW mode not being available anymore (it's
>emulated!) could be circumvented by having both the RAW and
>translated codes move between layers.

Ouch! If the user asks for raw mode, he doesn't get it, but some emulated
mode? To me this sounds like a big incompatibility. Fortunately this patch
(written together with Sau Dan Lee) should give _really_ raw mode in 2.6.x
too (but it's not compatible with the raw mode in 2.4.x):

http://www.ee.oulu.fi/~tuukkat/tmp/linux-2.6.5-userdev.20040507.patch
