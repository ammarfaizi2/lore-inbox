Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751811AbWITQhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbWITQhQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 12:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbWITQhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 12:37:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16782 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751811AbWITQhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 12:37:14 -0400
Date: Wed, 20 Sep 2006 12:36:52 -0400
From: Dave Jones <davej@redhat.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Andrew Morton <akpm@osdl.org>, Alex Dubov <oakad@yahoo.com>,
       linux-kernel@vger.kernel.org, drzeus-list@drzeus.cx,
       rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH 1/2] [MMC] Driver for TI FlashMedia card reader - source
Message-ID: <20060920163652.GF30550@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>,
	Andrew Morton <akpm@osdl.org>, Alex Dubov <oakad@yahoo.com>,
	linux-kernel@vger.kernel.org, drzeus-list@drzeus.cx,
	rmk+lkml@arm.linux.org.uk
References: <20060920060212.7327.qmail@web36712.mail.mud.yahoo.com> <20060919232016.68a02e0e.akpm@osdl.org> <84144f020609192328k4a2b2a70w5b068f49649398d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020609192328k4a2b2a70w5b068f49649398d6@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 09:28:05AM +0300, Pekka Enberg wrote:
 > On 9/20/06, Andrew Morton <akpm@osdl.org> wrote:
 > > Trivia:
 > 
 > [snip]
 > 
 > More trivia:
 > 
 >   - Unnecessary casts for void pointers
 >   - Assignment in if statement expression

also

+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>

Some unnecessary includes there. (config.h & kernel.h are auto-included)

	Dave
