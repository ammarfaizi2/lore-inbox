Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965036AbWEBXW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbWEBXW0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 19:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbWEBXW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 19:22:26 -0400
Received: from canuck.infradead.org ([205.233.218.70]:39398 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S965036AbWEBXW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 19:22:26 -0400
Subject: Re: [PATCH] CodingStyle: add typedefs chapter
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, js@linuxtv.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.64.0605021204240.4086@g5.osdl.org>
References: <20060430174426.a21b4614.rdunlap@xenotime.net>
	 <1146503166.2885.137.camel@hades.cambridge.redhat.com>
	 <20060502003755.GA26327@linuxtv.org>
	 <1146576495.14059.45.camel@pmac.infradead.org>
	 <20060502142050.GC27798@linuxtv.org>
	 <1146580308.17934.19.camel@pmac.infradead.org>
	 <20060502101113.17c75a05.rdunlap@xenotime.net>
	 <Pine.LNX.4.64.0605021137500.4086@g5.osdl.org>
	 <1146595853.19101.38.camel@pmac.infradead.org>
	 <Pine.LNX.4.64.0605021204240.4086@g5.osdl.org>
Content-Type: text/plain
Date: Wed, 03 May 2006 00:22:16 +0100
Message-Id: <1146612136.19101.47.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-02 at 12:07 -0700, Linus Torvalds wrote:
> And that wasn't what I objected to. 
> 
> What I objected to was that other part, which said that "uint32_t" was 
> somehow more standard.

It didn't say "more standard". It referred to "the standard C99 types".

It's heading off the question "why object to ifdefs but permit _these_
gratuitous ones?" which would otherwise be asked.

It's a document which is _describing_ the Linux coding style. To refer
to u32 et al as 'standard' would be self-referential. Describe them as
'the Linux standard types' in other documents by all means, but it
doesn't make much sense to do so in Documentation/CodingStyle.

-- 
dwmw2

