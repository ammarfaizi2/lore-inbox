Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287641AbSALXy0>; Sat, 12 Jan 2002 18:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287645AbSALXyR>; Sat, 12 Jan 2002 18:54:17 -0500
Received: from zero.tech9.net ([209.61.188.187]:63760 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S287641AbSALXyG>;
	Sat, 12 Jan 2002 18:54:06 -0500
Subject: Re: [patch] O(1) scheduler, -G1, 2.5.2-pre10, 2.4.17 (fwd)
From: Robert Love <rml@tech9.net>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: timothy.covell@ashavan.org,
        =?ISO-8859-1?Q?Fran=E7ois?= Cami <stilgar2k@wanadoo.fr>,
        Ingo Molnar <mingo@elte.hu>, Mike Kravetz <kravetz@us.ibm.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Anton Blanchard <anton@samba.org>, george anzinger <george@mvista.com>,
        Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.40.0201121237110.1559-100000@blue1.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.40.0201121237110.1559-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 12 Jan 2002 18:56:43 -0500
Message-Id: <1010879815.3560.5.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-01-12 at 15:44, Davide Libenzi wrote:

> My opinion is: if it can be solved with no more than 20 lines of code
> let's do it, otherwise let's see what kind of catastrophe will happen by
> allowing such behavior. Because i've already seen hundreds of lines of
> code added to solve corner cases and removed after 3-4 years because
> someone realized that maybe such corner cases does not matter more than a
> whit.
> I'll be happy to be shut down here ...

Completely agreed.  I think its an unfair situation (we may see
administrators timing the order they start large batch tasks), but it is
a corner case and we do have an "optimal cache use" counterargument.

	Robert Love

