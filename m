Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWEBOU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWEBOU6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 10:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWEBOU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 10:20:58 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:39842 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S964839AbWEBOU5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 10:20:57 -0400
Date: Tue, 2 May 2006 16:20:50 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <20060502142050.GC27798@linuxtv.org>
References: <20060430174426.a21b4614.rdunlap@xenotime.net> <1146503166.2885.137.camel@hades.cambridge.redhat.com> <20060502003755.GA26327@linuxtv.org> <1146576495.14059.45.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1146576495.14059.45.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.11+cvs20060403
X-SA-Exim-Connect-IP: 84.190.188.16
Subject: Re: [PATCH] CodingStyle: add typedefs chapter
X-SA-Exim-Version: 4.2.1 (built Mon, 27 Mar 2006 13:42:28 +0200)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006, David Woodhouse wrote:
> On Tue, 2006-05-02 at 02:37 +0200, Johannes Stezenbach wrote:
> > IMHO u32 etc. are the well established data types used
> > everywhere in kernel source. Your wording suggests that
> > the use of C99 types would be better, and while I respect
> > your personal opinion, I think it is wrong to put that in the
> > kernel CodingStyle document.
> 
> Perhaps the word 'gratuitous' should be removed, then, if you object to
> being able to infer my opinion.
> 
> The point remains that the peculiarity should definitely be documented,
> along with an explanation of the reasoning (or lack of such) behind it.
> 
> > c.f. http://lkml.org/lkml/2004/12/14/127 
> 
> That's about types used for _export_. It's accepted that __uXX types are
> necessary in stuff which is visible by userspace. That was point (e).¹
> 
> The only bit in that mail which is relevant to my point (d) is the
> penultimate (and final) paragraphs. And those are a complete non
> sequitur and make just as much sense if you swap over 'u32' and
> 'uint32_t' and also 'kernel' and 'C language'...
> 
> "In other words, uint8_t/uint16_t/uint32_t/uint64_t (and the signed
> versions: int8_t and friends) _are_ the standard names in the C
> language, and the __u8/__u16/etc versions have always existed alongside
> them for things like header files that have namespace issues.
> 
> "So forget about that stupid abortion called "u32" already. It buys
> you absolutely nothing."

;-)

Maybe I got it wrong, but my impression so far was that
u8 etc. are preferred for kernel code, and C99 types
are merely tolerated. (Mostly for consistency reasons,
I guess, since most old code uses u8 etc.)

However, personally I don't care either way, I just
want to make sure that code written acording to
Documentation/CodingStyle also meets Linus' expectations.


Johannes
