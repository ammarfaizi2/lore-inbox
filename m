Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267689AbSLTCQ1>; Thu, 19 Dec 2002 21:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267687AbSLTCQ1>; Thu, 19 Dec 2002 21:16:27 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:27116
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267689AbSLTCQ0>; Thu, 19 Dec 2002 21:16:26 -0500
Subject: Re: Intel P6 vs P7 system call performance
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "H. Peter Anvin" <hpa@transmeta.com>,
       Ulrich Drepper <drepper@redhat.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021218234512.GA705@elf.ucw.cz>
References: <3DFFED33.2020201@transmeta.com>
	<Pine.LNX.4.44.0212172005500.1230-100000@home.transmeta.com> 
	<20021218234512.GA705@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Dec 2002 03:05:15 +0000
Message-Id: <1040353515.30925.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-18 at 23:45, Pavel Machek wrote:
> IIRC, segment 0x40 was special in BIOS days, and some APM bioses
> blindly access 0x40 even from protected mode (windows have segment
> 0x40 with base 0x400....) Is that issue you are hitting?

Well the spec says it is not special. Windows leaves it pointing to
0x400 and if you don't do that your APM doesn't work.

Alan

