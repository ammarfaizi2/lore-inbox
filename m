Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313166AbSDDMsQ>; Thu, 4 Apr 2002 07:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312311AbSDDMsH>; Thu, 4 Apr 2002 07:48:07 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:57754 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S313166AbSDDMru>;
	Thu, 4 Apr 2002 07:47:50 -0500
Date: Thu, 4 Apr 2002 13:46:06 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: <tigran@einstein.homenet>
To: Russell King <rmk@arm.linux.org.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <20020404134046.H27376@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0204041344080.1475-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2002, Russell King wrote:

> On Thu, Apr 04, 2002 at 01:01:47PM +0100, Tigran Aivazian wrote:
> > Namely, in the sense that it is inconsistent with the
> > similar situation in the case of libraries or even system calls.
>
> A GPL library can only be linked with other GPL-compatible code.  A LGPL
> library can be linked with any GPL-compatible or GPL-incompatible code.
> The LGPL has specific clauses in it that allows you to link GPL-incompatible
> code (see LGPL paragraph 5).  It seems that you're missing that distinction.

I wasn't actually missing that distinction and I am familiar with LGPL
reasonably well (had to study it as we do actually make use of it at
VERITAS). I was comparing LGPL with "Linux kernel flavour of GPL" rather
than LGPL with GPL.

>
> This is why glibc and other libraries are LGPL, not GPL.  If glibc was GPL,
> all the binary-only applications in user space would have to supply their
> own C library.
>

Yes, I know.

Regards,
Tigran

