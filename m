Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVBAAll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVBAAll (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 19:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVBAAkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 19:40:32 -0500
Received: from gate.crashing.org ([63.228.1.57]:7593 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261478AbVBAAi2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 19:38:28 -0500
Subject: Re: [PATCH] ppc64: Implement a vDSO and use it for signal
	trampoline
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20050131192713.GA16268@mars.ravnborg.org>
References: <1107151447.5712.81.camel@gaston>
	 <20050131192713.GA16268@mars.ravnborg.org>
Content-Type: text/plain
Date: Tue, 01 Feb 2005 11:38:02 +1100
Message-Id: <1107218282.5906.33.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Also notice that ':=' uses all over. No need to use late evaluation when
> no dynamic references are used ($ $@ etc.).

Hrm... Rusty tells me that you got it backward ;) Anyway, I'll stick
to := for now, it's not really an issue.

Ben.


