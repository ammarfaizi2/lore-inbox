Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317182AbSH3LNm>; Fri, 30 Aug 2002 07:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319545AbSH3LNm>; Fri, 30 Aug 2002 07:13:42 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:40174
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317182AbSH3LNl>; Fri, 30 Aug 2002 07:13:41 -0400
Subject: Re: [PATCH 1 / ...] i386 dynamic fixup/self modifying code
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Pavel Machek <pavel@suse.cz>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <1030666256.1491.143.camel@ldb>
References: <1030506106.1489.27.camel@ldb>  <20020828121129.A35@toy.ucw.cz>
	<1030663192.1326.20.camel@irongate.swansea.linux.org.uk> 
	<1030663772.1491.107.camel@ldb> 
	<1030663955.1327.27.camel@irongate.swansea.linux.org.uk> 
	<1030666256.1491.143.camel@ldb>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 30 Aug 2002 12:17:59 +0100
Message-Id: <1030706279.3180.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-30 at 01:10, Luca Barbieri wrote:
> That wouldn't work for compiler-generated prefetches (unless you
> preprocess the compiler output) and would enlarge the kernel.
> However, it would be significantly cleaner.

My general experience with compiler generated prefetches right now is
pretty poor for kernel type code. Its hard to do it right in the
compiler for complex stuff rather than 'fortran in C' type jobs

We certainly could perl the asm to drop in the right directives if it
became an issue, but there are children on the list so lets worry about
it if it becomes a problem

