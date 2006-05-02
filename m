Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbWEBSvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbWEBSvQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 14:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWEBSvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 14:51:16 -0400
Received: from canuck.infradead.org ([205.233.218.70]:49107 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S964966AbWEBSvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 14:51:15 -0400
Subject: Re: [PATCH] CodingStyle: add typedefs chapter
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, js@linuxtv.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.64.0605021137500.4086@g5.osdl.org>
References: <20060430174426.a21b4614.rdunlap@xenotime.net>
	 <1146503166.2885.137.camel@hades.cambridge.redhat.com>
	 <20060502003755.GA26327@linuxtv.org>
	 <1146576495.14059.45.camel@pmac.infradead.org>
	 <20060502142050.GC27798@linuxtv.org>
	 <1146580308.17934.19.camel@pmac.infradead.org>
	 <20060502101113.17c75a05.rdunlap@xenotime.net>
	 <Pine.LNX.4.64.0605021137500.4086@g5.osdl.org>
Content-Type: text/plain
Date: Tue, 02 May 2006 19:50:53 +0100
Message-Id: <1146595853.19101.38.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-02 at 11:41 -0700, Linus Torvalds wrote:
> The problem with uint32_t is that it's ugly, it used to be unportable, and 
> you can't use it in header files _anyway_.

Unportable? It's at least as portable as u32 is, surely? We probably
wouldn't have used <stdint.h> in the kernel anyway -- we define them
ourselves. 

The header files are completely irrelevant too -- we're talking about
'u32' not '__u32'.

The important thing is your belief that it's ugly, which is what was
documented.

> I really object to this whole thing. The fact is, "u8" and friends _are_ 
> the standard types as far as the kernel is concerned.  Claiming that they 
> aren't is just silly.

When describing the CodingStyle rules "thou shalt not use typedefs" we
do need to list the exceptions, and that includes 'u32' et al.

Yes, those _are_ acceptable in the kernel. That's what the document
_says_. It _doesn't_ say that they're not.

-- 
dwmw2

