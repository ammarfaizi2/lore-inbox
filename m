Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267023AbSLQUBe>; Tue, 17 Dec 2002 15:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267024AbSLQUBe>; Tue, 17 Dec 2002 15:01:34 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:27876
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267023AbSLQUBc>; Tue, 17 Dec 2002 15:01:32 -0500
Subject: Re: Intel P6 vs P7 system call performance
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DFF772E.2050107@transmeta.com>
References: <Pine.LNX.4.44.0212162204300.1800-100000@home.transmeta.com> 
	<3DFF772E.2050107@transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Dec 2002 20:49:31 +0000
Message-Id: <1040158171.20765.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-17 at 19:12, H. Peter Anvin wrote:
> The complexity only applies to nonsynchronized TSCs though, I would
> assume.  I believe x86-64 uses a vsyscall using the TSC when it can
> provide synchronized TSCs, and if it can't it puts a normal system call
> inside the vsyscall in question.

For x86-64 there is the hpet timer, which is a lot saner but I don't
think we can mmap it


