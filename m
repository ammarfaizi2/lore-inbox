Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268089AbUJOPxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268089AbUJOPxy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 11:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268092AbUJOPxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 11:53:54 -0400
Received: from cantor.suse.de ([195.135.220.2]:2520 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268089AbUJOPxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 11:53:43 -0400
Date: Fri, 15 Oct 2004 17:33:10 +0200
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org
Subject: New 4level pagetable patch
Message-Id: <20041015173310.0fead649.ak@suse.de>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Extends the Linux VM to 4level page tables.

ftp://ftp.suse.com/pub/people/ak/4level/4level-2.6.9rc4-2.gz

This is a minor update to the previous version with more architecture ports.

Any testing appreciated (especially on the untested architectures)

status:
i386 and x86-64 tested in previous version
ia64            tested and works
PPC64, PPC32, Alpha compile now, but are untested.

Porting a new architecture to it is quite straight forward, please see the i386
changes.  Any patches to support new architectures would be appreciated.

-Andi
