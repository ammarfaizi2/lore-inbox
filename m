Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWGEQj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWGEQj7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 12:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWGEQj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 12:39:59 -0400
Received: from canuck.infradead.org ([205.233.218.70]:11987 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S964867AbWGEQj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 12:39:58 -0400
Subject: Re: [PATCH 5/5] FRV: Introduce asm-offsets for FRV arch
From: David Woodhouse <dwmw2@infradead.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       bernds_cb1@t-online.de, linux-kernel@vger.kernel.org
In-Reply-To: <20060705144138.GA26545@mars.ravnborg.org>
References: <20060705132409.31510.22698.stgit@warthog.cambridge.redhat.com>
	 <20060705132419.31510.92219.stgit@warthog.cambridge.redhat.com>
	 <20060705144138.GA26545@mars.ravnborg.org>
Content-Type: text/plain
Date: Wed, 05 Jul 2006 17:39:45 +0100
Message-Id: <1152117585.2987.21.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-05 at 16:41 +0200, Sam Ravnborg wrote:
> It is no loner needed to include <linux/config.h>. 

Then let's kill it entirely... well, I've left it with a #error for now
because otherwise people will just keep asking where it is.

 git://git.infradead.org/~dwmw2/killconfig.h.git

 http://git.infradead.org/?p=users/dwmw2/killconfig.h.git

(It still sucks that I have to give both URLs because we can't use just
one for both pulling and browsing).

-- 
dwmw2

