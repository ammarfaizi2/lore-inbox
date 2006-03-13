Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWCMOah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWCMOah (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 09:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWCMOah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 09:30:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:22219 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750893AbWCMOah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 09:30:37 -0500
Subject: Re: [patch] Require VM86 with VESA framebuffer
From: Arjan van de Ven <arjan@infradead.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Antonino Daplas <adaplas@pol.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <200603130917_MC3-1-BA83-2167@compuserve.com>
References: <200603130917_MC3-1-BA83-2167@compuserve.com>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 15:30:26 +0100
Message-Id: <1142260227.3023.29.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-13 at 09:13 -0500, Chuck Ebbert wrote:
> Force VM86 when VESA framebuffer is enabled and fix a typo
> in the VM86 config entry. If VM86 is disabled there will
> be problems when starting X using the VESA driver.


this sounds wrong.

The kernel works fine; it's X that needs vm86.. (but it needs that
anyway).... but that's no reason to make one kernel option require
another....


