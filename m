Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbVG1RAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVG1RAK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 13:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbVG1Q6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 12:58:23 -0400
Received: from aun.it.uu.se ([130.238.12.36]:13717 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261733AbVG1Q4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 12:56:25 -0400
Date: Thu, 28 Jul 2005 18:48:49 +0200 (MEST)
Message-Id: <200507281648.j6SGmnf0023871@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: RFC: Raise required gcc version to 3.2 ?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2005 14:00:12 +0200, Adrian Bunk wrote:
>What is the oldest gcc we want to support in kernel 2.6?
>
>Currently, it's 2.95 .
>
>I'd suggest raising this to 3.2 which should AFAIK not be a problem for 
>any distribution supporting kernel 2.6 .
>
>Is there any good reason why we should not drop support for older 
>compilers?

You're asking the wrong question. The right question would be:
"Is there any good reason to drop support for older compilers?"

At least on i386, gcc-2.95.3 still works and has the advantage
of being much faster compile-time wise on older machines with
limited memory (like my 486 test box). And I'm not the only
one with that POV -- akpm also uses 2.95.

Of course, if keeping 2.95.3 support would somehow hinder the
kernel's development, then it should be removed. But so far I
haven't seen any real(*) evidence that this is the case.

(*) Moronic code with declarations after statements is not a
valid argument against 2.95.

/Mikael
