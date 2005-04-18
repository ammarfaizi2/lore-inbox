Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262160AbVDRS5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbVDRS5G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 14:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbVDRS5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 14:57:04 -0400
Received: from mail02.osl.basefarm.net ([81.93.160.49]:6839 "EHLO
	mail02.osl.basefarm.net") by vger.kernel.org with ESMTP
	id S262160AbVDRS42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 14:56:28 -0400
To: Arjan van de Ven <arjan@infradead.org>
Cc: Igor Shmukler <igor.shmukler@gmail.com>, Rik van Riel <riel@redhat.com>,
       Daniel Souza <thehazard@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: intercepting syscalls
References: <6533c1c905041511041b846967@mail.gmail.com>
	<1113588694.6694.75.camel@laptopd505.fenrus.org>
	<6533c1c905041512411ec2a8db@mail.gmail.com>
	<e1e1d5f40504151251617def40@mail.gmail.com>
	<6533c1c905041512594bb7abb4@mail.gmail.com>
	<Pine.LNX.4.61.0504180752220.3232@chimarrao.boston.redhat.com>
	<6533c1c905041807487a872025@mail.gmail.com>
	<1113836378.6274.69.camel@laptopd505.fenrus.org>
	<6533c1c9050418080639e41fb@mail.gmail.com>
	<1113837657.6274.74.camel@laptopd505.fenrus.org>
From: Terje Malmedal <tm@basefarm.com>
Date: Mon, 18 Apr 2005 20:56:10 +0200
In-Reply-To: <1113837657.6274.74.camel@laptopd505.fenrus.org> (Arjan van de
 Ven's message of "Mon, 18 Apr 2005 17:20:57 +0200")
Message-ID: <wvhis2jewxh.fsf@cornavin.basefarm.no>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Scan-Result: No virus found in message 1DNbQ1-0006MO-8Y.
X-Scan-Signature: mail02.osl.basefarm.net 1DNbQ1-0006MO-8Y 27e9314f2f4ad892222b651147465d32
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Arjan van de Ven]
>> > but also about doing things at the right layer. The syscall layer is
>> > almost NEVER the right layer.
>> > 
>> > Can you explain exactly what you are trying to do (it's not a secret I
>> > assume, kernel modules are GPL and open source after all, esp such
>> > invasive ones) and I'll try to tell you why it's wrong to do it at the
>> > syscall intercept layer... deal ?
>> 
>> now, when I need someone to tell I do something wrong, I know where to go :)

> ok i'll spice things up... I'll even suggest a better solution ;)

Hi. The promise wasn't made to me, but I'm hoping you will find a nice
and clean solution:

  Every so often there is bug in the kernel, by patching the
  syscall-table I have been able to fix bugs in ioperm and fsync without
  rebooting the box. 

  What do I do the next time I need to do something like this? 


-- 
 - Terje
tm@basefarm.no
