Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266406AbUA2UQF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 15:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266408AbUA2UQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 15:16:05 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:20935 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S266406AbUA2UP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 15:15:59 -0500
Date: Thu, 29 Jan 2004 21:15:56 +0100
From: David Weinehall <tao@acc.umu.se>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Lindent fixed to match reality
Message-ID: <20040129201556.GK16675@khan.acc.umu.se>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20040129193727.GJ21888@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040129193727.GJ21888@waste.org>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29, 2004 at 01:37:28PM -0600, Matt Mackall wrote:
> I've been fiddling with cleaning up some old code here and suggest the
> following to make Lindent match actual practice more closely. This does:
> 
> a) (no -psl)
> 
> void *foo(void) {
> 
>  instead of
> 
> void *
> foo(void) {
> 
> b) (no -bs) "sizeof(foo)" rather than "sizeof (foo)"

I can't really see the logic in this, though I know a lot of people do
it.  I try to stay consistent, thus I do:

if ()
for ()
case ()
while ()
sizeof ()
typeof ()

since they're all parts of the language, rather than
functions/macros or invocations of such.

[snip]

Of course, coding-style is religion, and religion as a topic is a
sure-fire way to turn every civil conversation into full out battle,
so I've begun building a bomb-shelter where I'm going to spend the next
few months...


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
