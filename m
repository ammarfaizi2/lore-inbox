Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267675AbSLSWYc>; Thu, 19 Dec 2002 17:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267664AbSLSWXI>; Thu, 19 Dec 2002 17:23:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44553 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267659AbSLSWWa>; Thu, 19 Dec 2002 17:22:30 -0500
Message-ID: <3E024880.4010802@transmeta.com>
Date: Thu, 19 Dec 2002 14:30:24 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021119
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: dean gaudet <dean-list-linux-kernel@arctic.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212162204300.1800-100000@home.transmeta.com> <Pine.LNX.4.50.0212162241150.26163-100000@twinlark.arctic.org> <20021218235327.GC705@elf.ucw.cz> <3E0245C1.5060902@transmeta.com> <20021219222136.GC17941@atrey.karlin.mff.cuni.cz> <3E0246DE.2010608@transmeta.com> <20021219222614.GE17941@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20021219222614.GE17941@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> User on cpu1 reads time, communicates it to cpu2, but cpu2 is drifted
> -50ns, so it reads time "before" time reported cpu1. And gets confused.
> 

How can you get that communication to happen in < 50 ns?

	-hpa


