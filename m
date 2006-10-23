Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWJWBlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWJWBlb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 21:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWJWBla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 21:41:30 -0400
Received: from ns1.suse.de ([195.135.220.2]:21199 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751086AbWJWBl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 21:41:29 -0400
From: Andi Kleen <ak@suse.de>
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: dealing with excessive includes
Date: Mon, 23 Oct 2006 03:41:23 +0200
User-Agent: KMail/1.9.5
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Randy Dunlap <rdunlap@xenotime.net>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
References: <20061018091944.GA5343@martell.zuzino.mipt.ru> <200610230331.16573.ak@suse.de> <20061023013604.GF25210@parisc-linux.org>
In-Reply-To: <20061023013604.GF25210@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610230341.23978.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This needs annotations to fix, or a big bag of unreliable heuristics.

Ok you're right that case would need annotations.

I retreat my earlier statement that self sufficient include files
are a good idea.  If it needs such hacks to do it it's probably not worth
it. After all it won't fix a single bug.

-Andi
