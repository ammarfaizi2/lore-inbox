Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVEQHQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVEQHQq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 03:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVEQHQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 03:16:46 -0400
Received: from [80.247.74.3] ([80.247.74.3]:24247 "EHLO tavolara.isolaweb.it")
	by vger.kernel.org with ESMTP id S261292AbVEQHQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 03:16:43 -0400
Message-Id: <6.2.1.2.2.20050517091317.09915810@mail.tekno-soft.it>
X-Mailer: QUALCOMM Windows Eudora Version 6.2.1.2
Date: Tue, 17 May 2005 09:15:46 +0200
To: Nix <nix@esperi.org.uk>
From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: How to use memory over 4GB
Cc: Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org
In-Reply-To: <87hdh2am9j.fsf@amaterasu.srvr.nix>
References: <6.2.1.2.2.20050516142516.0313e860@mail.tekno-soft.it>
 <428898CF.5060908@cosmosbay.com>
 <6.2.1.2.2.20050516151659.077cceb0@mail.tekno-soft.it>
 <4288AB6A.3060106@cosmosbay.com>
 <6.2.1.2.2.20050516164236.05922a30@mail.tekno-soft.it>
 <87hdh2am9j.fsf@amaterasu.srvr.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-IsolaWeb-MailScanner-Information: Please contact the ISP for more information
X-IsolaWeb-MailScanner: Found to be clean
X-MailScanner-From: kernel@tekno-soft.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 23.34 16/05/2005, Nix wrote:
>On 16 May 2005, Roberto Fichera whispered secretively:
> > At 16.17 16/05/2005, Eric Dumazet wrote:
> >>If your process is cpu bounded (and not issuing too many system calls),
> >> then 4GB/4GB split let it address more ram, reducing the need to shift 
> windows in
> >>mmaped files for example.
> >
> > ... any source code that explain better what you say ;-)!
>
><http://lkml.org/lkml/2003/7/8/246> perhaps?

Yes! I already know this patch ... I was asking for some user space code,
just to show up the thinks ;-)!


>(In a nutshell: it gives processes an extra 1Gb of virtual memory, at
>the cost of making system calls --- and everything else that must
>transition to kernel space --- *much* slower.)
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

Roberto Fichera. 

