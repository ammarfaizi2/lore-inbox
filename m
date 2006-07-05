Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWGEQss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWGEQss (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 12:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWGEQsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 12:48:47 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:25733 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S964886AbWGEQsr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 12:48:47 -0400
Date: Wed, 5 Jul 2006 18:48:28 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       bernds_cb1@t-online.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] FRV: Introduce asm-offsets for FRV arch
Message-ID: <20060705164828.GA8196@mars.ravnborg.org>
References: <20060705132409.31510.22698.stgit@warthog.cambridge.redhat.com> <20060705132419.31510.92219.stgit@warthog.cambridge.redhat.com> <20060705144138.GA26545@mars.ravnborg.org> <1152117585.2987.21.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152117585.2987.21.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It is no loner needed to include <linux/config.h>. 
> 
> Then let's kill it entirely... well, I've left it with a #error for now
> because otherwise people will just keep asking where it is.

That will be bad for all out-of-tree stuff.
Now they have to track down if the kernel they build for
are before or after we stuffed in #error in config.h

A #warning would be more appropriate.

	Sam
