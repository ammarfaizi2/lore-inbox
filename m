Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbTDHLu5 (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 07:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbTDHLu5 (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 07:50:57 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:62367 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S261309AbTDHLu4 (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 07:50:56 -0400
Message-Id: <200304081202.h38C2Wgu010663@post.webmailer.de>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Compiling kernel with SuSE 8.2/gcc 3.3
To: Stephan von Krawczynski <skraw@ithnet.com>, linux-kernel@vger.kernel.org
Date: Tue, 08 Apr 2003 14:02:05 +0200
References: <20030408115008$0cd2@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:

> during tests with latest SuSE distro 8.2 compiling 2.4.21-pre6 showed a lot of
> "comparison between signed and unsigned" warnings. It looks like SuSE ships gcc
> 3.3 (prerelease). Is this compiler known to work for kernel compilation? Should
> therefore all these warnings be fixed?

We're building 2.4 and 2.5 kernels for s390 with a gcc-3.3 snapshot and we had to
fix a few places in the kernel source to make that work reliably. See
http://marc.theaimsgroup.com/?t=104611164800008&r=1&w=2 for more about this.
I have also tried using gcc-3.3 for building a 2.4 i386 kernel and needed a
small patch, but ymmv.

        Arnd <><
