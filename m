Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315785AbSENPla>; Tue, 14 May 2002 11:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315786AbSENPla>; Tue, 14 May 2002 11:41:30 -0400
Received: from daimi.au.dk ([130.225.16.1]:37680 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S315785AbSENPl2>;
	Tue, 14 May 2002 11:41:28 -0400
Message-ID: <3CE1300A.990919E2@daimi.au.dk>
Date: Tue, 14 May 2002 17:40:58 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] ext2 and ext3 block reservations can be bypassed
In-Reply-To: <200205131709.g4DH9Fjv006328@pincoya.inf.utfsm.cl>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> 
> Elladan <elladan@eskimo.com> said:
> 
> [...]
> 
> > Regardless of whether it's a good thing to depend on security-wise, it
> > is a problem to have something that appears to be a security feature
> > which doesn't actually work.
> 
> It is _not_ a security feature, it is meant to keep the filesystem from
> fragmenting too badly. root can use that space, since root can do whatever
> she wants anyway.

My point was that anybody can use this space if they want to.

While this feature might not be intended to be used for
security purposes, the documentation says the space is
reserved for the super-user. And in many cases it would be
convenient to use the feature for that purpose.

Since this would be a usefull feature for many people, and
since it AFAIK cannot be acomplished with quotas, I suggest
we find a way to make it work like most people would expect.

Would it cause any problems if the kernel ensured that the
block reservations could not be bypassed by users?

I have not yet verified if the same problem exists when
using quotas. (My kernel is compiled without quotas). But
if it does I guess we all would like to have it fixed.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
