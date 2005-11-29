Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbVK2Xwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbVK2Xwn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 18:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbVK2Xwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 18:52:43 -0500
Received: from krl.krl.com ([192.147.32.3]:57245 "EHLO krl.krl.com")
	by vger.kernel.org with ESMTP id S1751404AbVK2Xwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 18:52:42 -0500
Date: Tue, 29 Nov 2005 18:52:30 -0500
Message-Id: <200511292352.jATNqUiu004910@p-chan.krl.com>
From: Don Koch <aardvark@krl.com>
To: Michael Krufky <mkrufky@m1k.net>
Cc: kirk.lapray@gmail.com, gene.heskett@verizon.net,
       video4linux-list@redhat.com, CityK@rogers.com,
       linux-kernel@vger.kernel.org, perrye@linuxmail.org
Subject: Re: Gene's pcHDTV 3000 analog problem
In-Reply-To: <438CDDBC.1070704@m1k.net>
References: <200511282205.jASM5YUI018061@p-chan.krl.com>
	<200511291335.18431.gene.heskett@verizon.net>
	<438CA1E3.7010101@m1k.net>
	<200511291546.27365.gene.heskett@verizon.net>
	<438CC83E.50100@m1k.net>
	<c35b44d70511291435i5f07bc88g429276ef659c28c5@mail.gmail.com>
	<438CDDBC.1070704@m1k.net>
Organization: KRL
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.4.14; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Nov 2005 18:01:16 -0500
Michael Krufky wrote:


> 
> Gene, Perry and Don .... Another thing you can try -- Once again, 
> install v4l-dvb cvs on top of your running kernel, but this time, before 
> compiling, edit v4l-dvb/v4l/Makefile , and remove the line:
> 
>  EXTRA_CFLAGS += -DHAVE_NXT200X=1
> 
> ... This line appears twice, you only need to remove the top one, as it 
> pertains to the cx88 card, although it is safe to remove both for the 
> purposes of this test.
> 
> If this fixes your problem, then we know that nxt200x is the cause.
> 
> -Mike
> 

No difference.

Back to looking at the code...

-d
