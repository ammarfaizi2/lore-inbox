Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264029AbTFWHSg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 03:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264066AbTFWHSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 03:18:36 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:57291 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S264029AbTFWHSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 03:18:35 -0400
Subject: Re: [PATCH] Fix mtdblock / mtdpart / mtdconcat
From: David Woodhouse <dwmw2@redhat.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030623082235.A22114@flint.arm.linux.org.uk>
References: <20030623010031.E16537@flint.arm.linux.org.uk>
	 <1056352749.29264.0.camel@passion.cambridge.redhat.com>
	 <20030623082235.A22114@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Red Hat UK Ltd.
Message-Id: <1056353561.29264.4.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Mon, 23 Jun 2003 08:32:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-23 at 08:22, Russell King wrote:
> On Mon, Jun 23, 2003 at 08:19:09AM +0100, David Woodhouse wrote:
> > On Mon, 2003-06-23 at 01:00, Russell King wrote:
> > > Dirtily disable ECC support; it doesn't work when mtdpart is layered
> > > on top of mtdconcat on top of CFI flash.
> > 
> > Please define "doesn't work".
> 
> Remember those errors I reported to you last night?  That "doesn't work".

/me reads the scrollback.... oh, I see.

You'd do better to disable it in mtdconcat not mtdpart.

-- 
dwmw2
