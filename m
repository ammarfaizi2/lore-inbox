Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271026AbTGQHbG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 03:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271035AbTGQHbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 03:31:06 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:52997 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S271026AbTGQHbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 03:31:05 -0400
Subject: Re: [PATCH] O6.1int
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Wade <neroz@ii.net>,
       Eugene Teo <eugene.teo@eugeneteo.net>, Wiktor Wodecki <wodecki@gmx.de>
In-Reply-To: <200307171213.02643.kernel@kolivas.org>
References: <200307171213.02643.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1058427955.754.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 17 Jul 2003 09:45:56 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-17 at 04:13, Con Kolivas wrote:
> The bug in the O6int patch probably wasn't responsible for WIktor's problem 
> actually. It shouldn't manifest for a very long time. Anyway here is the fix 
> and a couple of minor cleanups.

This is even better than plain O6-int. Everything is nearly perfect. 
One thing I dislike a bit is that on my slow PIII 700Mhz, moving a
medium-sized window over Evolution 1.4.3 main window (displaying my
INBOX full of messages) makes the window movement a little jumpy
(Evolution 1.4.3 is well-known to be a serious CPU hogger when
repainting windows).

Renicing X to -20 helps a little with the jumpiness.
Nice work, indeed!

