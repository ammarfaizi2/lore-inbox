Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbTLDEsm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 23:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbTLDEsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 23:48:42 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:25474 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262078AbTLDEsl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 23:48:41 -0500
Date: Thu, 4 Dec 2003 04:48:37 +0000
From: Jamie Lokier <jamie@shareable.org>
To: David Lang <david.lang@digitalinsight.com>
Cc: Aaron Smith <aws4y@virginia.edu>, linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031204044837.GF1216@mail.shareable.org>
References: <3FCDE5CA.2543.3E4EE6AA@localhost> <Pine.LNX.4.58.0312031533530.2055@home.osdl.org> <3FCE854A.70404@virginia.edu> <Pine.LNX.4.58.0312031742150.8229@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312031742150.8229@dlang.diginsite.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> becouse of this you could take the kernel and include any propriatary code
> in it that you want and run it. You don't even need to use modules, just
> paste in th code and compile (make sure you have a legal right to the code
> you are pasting in though :-)

To elaborate on this: most patches which apply to the Linux kernel are
clearly derived works of the kernel.[*]

You can write and apply such a patch , but if you distribute the patch
it must be licensed under the GPL.

Thus while _you_ may take a Linux kernel and include any proprietary
code you want in it, a vendor _may not_ send you a patch which applies
to the Linux kernel if the patch is not licensed under the GPL or a
compatible license.  A vendor is not allowed to restrict your rights
in this way.

[*] Exceptions would be patches which are very small (<10 lines is
sometimes suggested, but it's not a hard boundary), and patches which
simply add code which is clearly not derived form the kernel, as Linus
described.

-- Jamie
