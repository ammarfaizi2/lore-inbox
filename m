Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262224AbVBBJze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbVBBJze (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 04:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbVBBJze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 04:55:34 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:56553 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262224AbVBBJz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 04:55:26 -0500
From: Peter Busser <busser@m-privacy.de>
Organization: m-privacy
To: "Theodore Ts'o" <tytso@mit.edu>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Sabotaged PaXtest (was: Re: Patch 4/6  randomize the stack pointer)
Date: Wed, 2 Feb 2005 10:55:18 +0100
User-Agent: KMail/1.7.1
References: <200501311015.20964.arjan@infradead.org> <20050202001549.GA17689@thunk.org> <20050202082643.GA6172@thunk.org>
In-Reply-To: <20050202082643.GA6172@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502021055.18923.busser@m-privacy.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e784f4497a7e52bfc8179ee7209408c3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 February 2005 09:26, Theodore Ts'o wrote:
> On Tue, Feb 01, 2005 at 07:15:49PM -0500, Theodore Ts'o wrote:
> > Umm, so exactly how many applications use multithreading (or otherwise
> > trigger the GLIBC mprotect call),
>
> For the record, I've been informed that the glibc mprotect() call
> doesn't happen in any modern glibc's; there may have been one buggy
> glibc that was released very briefly before it was fixed in the next
> release.  But if that's what the paxtest developers are hanging their
> hat on, it seems awfully lame to me.....
>
> "desabotaged" seems like the correct description from my vantage
> point.

Well, great! One problem eliminated.

Anyways, for me it is not important whether what GLIBC exactly does or doesn't 
do. There are tons of different libraries and applications which do all kinds 
of stuff. You can only guess what exactly goes on. And not all compilers 
generate PT_GNU_STACK stuff either. And so on and so forth.

What is important to me is the question whether the PaXtest results are 
accurately reflecting the underlying system or not. Therefore I would like to 
see proof that exec-shield does NOT open up in situations where PaXtest says 
it does. So far I have seen ``sabotage'' FUD, opinions and excuses. But no 
proof. Nor any reasonable evidence. That doesn't surprise me, because PaXtest 
is accurate in what it does.

Groetjes,
Peter.
