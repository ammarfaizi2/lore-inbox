Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272566AbTHEHbQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 03:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272567AbTHEHbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 03:31:15 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:38404 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S272566AbTHEHbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 03:31:12 -0400
Subject: Re: [PATCH] O13.1int
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200308051017.55616.kernel@kolivas.org>
References: <200308051017.55616.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1060068667.556.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 05 Aug 2003 09:31:07 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-05 at 02:17, Con Kolivas wrote:
> A heck of a lot fairer on disk only tasks; lets them earn sleep avg up to just 
> interactive state so they stay on the active array.

This one is more "jumpy" (i.e., not as smooth as) than just the previous
release. I have had to renice X back to -20 in order to get smooth
window movements involving heavyweight CPU programs like Evolution.

Also, with X at -20, XMMS skips are still present, but they are a little
bit shorter than with previous iterations.

