Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318849AbSIIUdW>; Mon, 9 Sep 2002 16:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318881AbSIIUdV>; Mon, 9 Sep 2002 16:33:21 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:53487
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318849AbSIIUdU>; Mon, 9 Sep 2002 16:33:20 -0400
Subject: Re: [PATCH][RFC] per isr in_progress markers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Zwane Mwaikambo <zwane@mwaikambo.name>
Cc: Ingo Molnar <mingo@elte.hu>, Robert Love <rml@tech9.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0209081250000.1096-100000@linux-box.realnet.co.sz>
References: <Pine.LNX.4.44.0209081250000.1096-100000@linux-box.realnet.co.sz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 09 Sep 2002 21:40:35 +0100
Message-Id: <1031604035.29792.27.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-08 at 11:57, Zwane Mwaikambo wrote:
> iirc IDE is capable of doing its own masking per device(nIEN) and in fact 
> does even do unconditional sti's in its isr paths. So i would think it 
> would be one of the not so painful device drivers to take care of. 

If I remember rightly nIEN doesnt work everywhere. Also many IDE
interfaces may be using legacy IRQ wiring rather than PCI irq lines. 

