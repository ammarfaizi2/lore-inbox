Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267139AbSLQV3D>; Tue, 17 Dec 2002 16:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267148AbSLQV3C>; Tue, 17 Dec 2002 16:29:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1552 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267139AbSLQV3B>; Tue, 17 Dec 2002 16:29:01 -0500
Message-ID: <3DFF98F5.60706@transmeta.com>
Date: Tue, 17 Dec 2002 13:36:53 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021119
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Ulrich Drepper <drepper@redhat.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
References: <1040153030.20804.8.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0212171046550.1095-100000@home.transmeta.com> <20021217163458.B10781@redhat.com>
In-Reply-To: <20021217163458.B10781@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
>
> The stubs I used for the vsyscall bits just did an absolute jump to 
> the vsyscall page, which would then do a ret to the original calling 
> userspace code (since that provided library symbols for the user to 
> bind against).
> 

What kind of "absolute jumps" were this?

	-hpa


