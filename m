Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264533AbTH2MBs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 08:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264549AbTH2MBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 08:01:48 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:31238 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264533AbTH2MB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 08:01:28 -0400
Subject: Re: [PATCH]O19int
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200308291550.28159.kernel@kolivas.org>
References: <200308291550.28159.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1062158484.671.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 29 Aug 2003 14:01:24 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-29 at 07:50, Con Kolivas wrote:

> Small error in the just interactive logic has been corrected.
> 
> Idle tasks get one higher priority than just interactive so they don't get 
> swamped under heavy load.
> 
> Cosmetic cleanup.
> 
> Patch against 2.6.0-test4-mm2

Spectacular!
Smooth as silk and, when combined with CFQ scheduler, it's impossible to
make sound skip, even under heavy CPU and I/O load.

