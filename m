Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbTEIMlQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 08:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbTEIMlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 08:41:16 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:24203
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262513AbTEIMlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 08:41:15 -0400
Subject: Re: [PATCH] i386 uaccess to fixmap pages
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roland McGrath <roland@redhat.com>
Cc: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200305091043.h49Ah7Z24822@magilla.sf.frob.com>
References: <200305091043.h49Ah7Z24822@magilla.sf.frob.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052481316.14538.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 May 2003 12:55:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-05-09 at 11:43, Roland McGrath wrote:
> Here's an updated version of the patch.  Since the support for 386s without
> WP support seems to be gone, I shaved an instruction here and there by not
> passing the read/write flag to the helper function.  

Manfred Spraul redid the 386 support very nicely so the older CPU's
should be fine

