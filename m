Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264989AbTIJPYk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 11:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264998AbTIJPYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 11:24:40 -0400
Received: from hal-5.inet.it ([213.92.5.24]:12466 "EHLO hal-5.inet.it")
	by vger.kernel.org with ESMTP id S264989AbTIJPYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 11:24:37 -0400
Message-ID: <05ec01c377b0$31535480$5aaf7450@wssupremo>
Reply-To: "Luca Veraldi" <luca.veraldi@katamail.com>
From: "Luca Veraldi" <luca.veraldi@katamail.com>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
References: <u9j3.1VB.27@gated-at.bofh.it> <u9j3.1VB.29@gated-at.bofh.it> <u9j3.1VB.31@gated-at.bofh.it> <u9j3.1VB.25@gated-at.bofh.it> <ubNY.5Ma.19@gated-at.bofh.it> <uc79.6lg.13@gated-at.bofh.it> <uc7d.6lg.23@gated-at.bofh.it> <uch0.6zx.17@gated-at.bofh.it> <ucqs.6NC.3@gated-at.bofh.it> <ucqy.6NC.19@gated-at.bofh.it> <udmB.8eZ.15@gated-at.bofh.it> <udPF.BD.11@gated-at.bofh.it> <3F5F37CD.6060808@softhome.net>
Subject: Re: Efficient IPC mechanism on Linux
Date: Wed, 10 Sep 2003 17:28:27 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    Can you forward-port your work to 2.6 kernel?
>    Can you benchmarkt it against the same primitives in 2.6 kernel?

I could do it only if there was an effective reason to do it. 
And there isn't.

They have just posted me a message with pipe latency under kernel 2.4.
And it is exactly the same (apart some minor variations in misurements 
that are natural enough).

>    You have just started your work - are you going to finish it? Or it 
> was just-another-academical-study?

I consider my work finished.
I studied an efficient IPC mechanism and I tried to implement it 
on an existing Operating System.

I tried some other IPC primitives in benchmark tests 
and reported the comparisons between completion times.

I got my goal.

>    If you can try to develop new sematics for old syntax (shm* & etc) it 
> can be welcomed too.
>    And if it would be poll()able - it would be great. Applications which 
> do block on read()/getmsg() in real-life not that common, and as I've 
> understood - this is the case for your message passing structure.

I'm not a kernel developer. Ask Linus Torvalds.

Bye,
Luca
