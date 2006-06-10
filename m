Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932505AbWFJXcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbWFJXcm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 19:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbWFJXcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 19:32:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:35301 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932505AbWFJXcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 19:32:41 -0400
Subject: Re: [PATCH] jffs2: fix section mismatches
From: David Woodhouse <dwmw2@infradead.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20060610162945.b8823f6e.rdunlap@xenotime.net>
References: <20060610132803.8909971c.rdunlap@xenotime.net>
	 <1149976818.18635.153.camel@shinybook.infradead.org>
	 <20060610162945.b8823f6e.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Sun, 11 Jun 2006 00:32:48 +0100
Message-Id: <1149982369.18635.202.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-10 at 16:29 -0700, Randy.Dunlap wrote:
> > For those exit-and-error functions, I think we actually want an
> > __initexit marker. In the built-in case, it can actually be discarded
> > with the init code. In the modular case, it needs to be kept.
> 
> That sounds good, yes.

In practice we could just use __init for it, until such time as we
actually start discarding initcode from modules.

-- 
dwmw2

