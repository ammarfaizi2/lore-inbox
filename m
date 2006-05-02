Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbWEBOb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWEBOb4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 10:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWEBOb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 10:31:56 -0400
Received: from canuck.infradead.org ([205.233.218.70]:54912 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S964841AbWEBOb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 10:31:56 -0400
Subject: Re: [PATCH] CodingStyle: add typedefs chapter
From: David Woodhouse <dwmw2@infradead.org>
To: Johannes Stezenbach <js@linuxtv.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060502142050.GC27798@linuxtv.org>
References: <20060430174426.a21b4614.rdunlap@xenotime.net>
	 <1146503166.2885.137.camel@hades.cambridge.redhat.com>
	 <20060502003755.GA26327@linuxtv.org>
	 <1146576495.14059.45.camel@pmac.infradead.org>
	 <20060502142050.GC27798@linuxtv.org>
Content-Type: text/plain
Date: Tue, 02 May 2006 15:31:48 +0100
Message-Id: <1146580308.17934.19.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-02 at 16:20 +0200, Johannes Stezenbach wrote:
> Maybe I got it wrong, but my impression so far was that
> u8 etc. are preferred for kernel code, and C99 types
> are merely tolerated. (Mostly for consistency reasons,
> I guess, since most old code uses u8 etc.)

It depends. In existing code, you should follow the precedent which is
set already. In new code of your own, you do as you see fit. Perhaps
that should be made clearer...

 (d) New types which are identical to standard C99 types, in certain
     exceptional circumstances.
 
     Although it would only take a short amount of time for the eyes and
     brain to become accustomed to the standard types like 'uint32_t',
     some people object to their use anyway.
 
     Therefore, the Linux-specific 'u8/u16/u32/u64' types and their
     signed equivalents which are identical to standard types are
     permitted -- although they are not mandatory in new code of your
     own.

     When editing existing code which already uses one or the other set
     of types, you should conform to the existing choices in that code.

-- 
dwmw2

