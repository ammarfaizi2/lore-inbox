Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270914AbTGPPHw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 11:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270922AbTGPPHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 11:07:52 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:41221 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S270914AbTGPPHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 11:07:45 -0400
Subject: Re: [PATCH] O6int for interactivity
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>
In-Reply-To: <200307170030.25934.kernel@kolivas.org>
References: <200307170030.25934.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1058368952.873.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 16 Jul 2003 17:22:33 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-16 at 16:30, Con Kolivas wrote:
> O*int patches trying to improve the interactivity of the 2.5/6 scheduler for 
> desktops. It appears possible to do this without moving to nanosecond 
> resolution.
> 
> This one makes a massive difference... Please test this to death.

Oh, my god... This is nearly perfect! :-)
On 2.6.0-test1-mm1 with o6int.patch, I can't reproduce XMMS initial
starvation anymore and X feels smoother under heavy load.
Nice... ;-)

