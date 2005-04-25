Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262618AbVDYOup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262618AbVDYOup (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 10:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbVDYOup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 10:50:45 -0400
Received: from fire.osdl.org ([65.172.181.4]:4747 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262618AbVDYOuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 10:50:39 -0400
Date: Mon, 25 Apr 2005 07:52:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
cc: git@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t
In-Reply-To: <426CD1F1.2010101@tiscali.de>
Message-ID: <Pine.LNX.4.58.0504250751330.18901@ppc970.osdl.org>
References: <426CD1F1.2010101@tiscali.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Apr 2005, Matthias-Christian Ott wrote:
>
> The "git" didn't try store small variables, which aren't referenced, in 
> the processor registers. It also didn't use the size_t type. I corrected 
> a C++ style comment too.

What kind of ancient C standard are you working against?

// isn't "C++" any more, and "register" variables are sooo 60's, man.

Pass the toke,

		Linus
