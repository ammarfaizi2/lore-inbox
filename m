Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbWG1Hss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbWG1Hss (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 03:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbWG1Hss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 03:48:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35231 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932580AbWG1Hsr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 03:48:47 -0400
Date: Fri, 28 Jul 2006 00:47:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: trivial@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use BUG_ON(foo) instead of "if (foo) BUG()" in
 include/asm-i386/dma-mapping.h
Message-Id: <20060728004758.5e7c5120.akpm@osdl.org>
In-Reply-To: <200607280928.54306.eike-kernel@sf-tec.de>
References: <200607280928.54306.eike-kernel@sf-tec.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2006 09:28:49 +0200
Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:

> We have BUG_ON() right for this, don't we?

Well yes, but there are over a thousand BUG->BUG_ON conversion
possibilities in the tree.  If people start sending them three-at-a-time
we'll all go mad.

So.  If we're going to do this, bigger patches, please.
