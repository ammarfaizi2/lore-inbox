Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290429AbSAPLkR>; Wed, 16 Jan 2002 06:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290427AbSAPLkH>; Wed, 16 Jan 2002 06:40:07 -0500
Received: from ns.suse.de ([213.95.15.193]:29456 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290419AbSAPLkA>;
	Wed, 16 Jan 2002 06:40:00 -0500
Date: Wed, 16 Jan 2002 12:39:51 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        <bcrl@redhat.com>
Subject: Re: [PATCH] Re: 2.5.3-pre1 compile error
In-Reply-To: <p73pu4aa63j.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.33.0201161238530.9083-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Jan 2002, Andi Kleen wrote:

> The first check is done automatically by the gcc preprocessor
> anyways (it has a special check for the #ifndef BLA_H #define BLA_H #endif
> construct for whole files and doesn't even bother to open them again on a
> second include). So it's completely unnecessary.

Ahah! I knew I didn't imagine it. Either that or we've both had the same
hallucination. 8-)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

