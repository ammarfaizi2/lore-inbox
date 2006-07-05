Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWGEQux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWGEQux (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 12:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbWGEQux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 12:50:53 -0400
Received: from canuck.infradead.org ([205.233.218.70]:1411 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S964881AbWGEQuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 12:50:52 -0400
Subject: Re: [PATCH 5/5] FRV: Introduce asm-offsets for FRV arch
From: David Woodhouse <dwmw2@infradead.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       bernds_cb1@t-online.de, linux-kernel@vger.kernel.org
In-Reply-To: <20060705164828.GA8196@mars.ravnborg.org>
References: <20060705132409.31510.22698.stgit@warthog.cambridge.redhat.com>
	 <20060705132419.31510.92219.stgit@warthog.cambridge.redhat.com>
	 <20060705144138.GA26545@mars.ravnborg.org>
	 <1152117585.2987.21.camel@pmac.infradead.org>
	 <20060705164828.GA8196@mars.ravnborg.org>
Content-Type: text/plain
Date: Wed, 05 Jul 2006 17:50:41 +0100
Message-Id: <1152118241.2987.23.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-05 at 18:48 +0200, Sam Ravnborg wrote:
> That will be bad for all out-of-tree stuff.
> Now they have to track down if the kernel they build for
> are before or after we stuffed in #error in config.h

No, they have to track down if the kernel they build for is before or
after the inclusion of config.h became unnecessary. That was actually
quite a while ago, wasn't it?

-- 
dwmw2

