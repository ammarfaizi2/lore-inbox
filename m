Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbVHHRPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbVHHRPn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 13:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbVHHRPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 13:15:43 -0400
Received: from graphe.net ([209.204.138.32]:43930 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S932119AbVHHRPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 13:15:43 -0400
Date: Mon, 8 Aug 2005 10:15:32 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Richard Purdie <rpurdie@rpsys.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       linux-arm@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3
In-Reply-To: <20050808181004.B12788@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.62.0508081014100.20322@graphe.net>
References: <1122933133.7648.141.camel@localhost.localdomain>
 <Pine.LNX.4.62.0508011517300.8498@graphe.net> <1122937261.7648.151.camel@localhost.localdomain>
 <Pine.LNX.4.62.0508031716001.24733@graphe.net> <1123154825.8987.33.camel@localhost.localdomain>
 <Pine.LNX.4.62.0508040703300.3277@graphe.net> <1123166252.8987.50.camel@localhost.localdomain>
 <Pine.LNX.4.62.0508050817060.28659@graphe.net> <1123422275.7800.24.camel@localhost.localdomain>
 <Pine.LNX.4.62.0508080945100.19665@graphe.net> <20050808181004.B12788@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Aug 2005, Russell King wrote:

> ARM doesn't have cmpxchg nor does it have hardware access nor dirty
> bits.  They're simulated in software.

Even the cmpxchg is simulated.

> What's the problem you're trying to solve?

A hang when starting X on ARM with rc4-mm1 which contains the page fault 
patches. But I have no access to the platform.
