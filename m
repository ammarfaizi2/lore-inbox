Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264339AbRFHVbe>; Fri, 8 Jun 2001 17:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264340AbRFHVbY>; Fri, 8 Jun 2001 17:31:24 -0400
Received: from pizda.ninka.net ([216.101.162.242]:33664 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264339AbRFHVbM>;
	Fri, 8 Jun 2001 17:31:12 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15137.17433.417079.475731@pizda.ninka.net>
Date: Fri, 8 Jun 2001 14:31:05 -0700 (PDT)
To: Felix von Leitner <leitner@fefe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux kernel headers violate RFC2553
In-Reply-To: <20010608211247.A12925@codeblau.de>
In-Reply-To: <20010608195719.A4862@fefe.de>
	<15137.8668.590390.10485@pizda.ninka.net>
	<20010608211247.A12925@codeblau.de>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Felix von Leitner writes:
 > Thus spake David S. Miller (davem@redhat.com):
 > > Don't user kernel headers for userspace.
 > 
 > What choice do I have?

I didn't say anything about choice, I said "don't use kernel headers
for userspace".  What part of it do you not understand.

It was decided long ago that keeping the kernel headers up to snuff
with "user space standard of the day" was not in our interests, so we
don't have "#if _POSIX == 19940XXX" type crap all over the kernel
headers.

In fact, in some headers the structures and names are purposely not
what userspace wants.  In this way nobody is likely to get the ill
conception that they are meant in any way to be used by userspace.

Later,
David S. Miller
davem@redhat.com
