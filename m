Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262255AbULMNB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbULMNB2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 08:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbULMNB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 08:01:28 -0500
Received: from em.njupt.edu.cn ([202.119.230.11]:42883 "HELO njupt.edu.cn")
	by vger.kernel.org with SMTP id S262255AbULMNAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 08:00:38 -0500
Message-ID: <302945938.22534@njupt.edu.cn>
X-WebMAIL-MUA: [10.10.136.115]
From: "Zhenyu Wu" <y030729@njupt.edu.cn>
To: quade@hsnr.de
Cc: linux-kernel@vger.kernel.org
Date: Mon, 13 Dec 2004 21:52:18 +0800
Reply-To: "Zhenyu Wu" <y030729@njupt.edu.cn>
X-Priority: 3
Subject: Re: about kernel_thread!
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, my god. I find another problem, my linux kernel is 2.4.20, and i can't find
the function allow_signal at all. BTW, whether there is such funcion in kernel
2.4.20?

Thanks,
Zhenyu Wu


>From: Juergen Quade <quade@hsnr.de>
>Reply-To: 
>To: Zhenyu Wu <y030729@njupt.edu.cn>
>Subject: Re: about kernel_thread!
>Date:Mon, 13 Dec 2004 13:44:26 +0100
>
>On Mon, Dec 13, 2004 at 09:12:39PM +0800, Zhenyu Wu wrote:
> > Hello, 
> > 
> > I have some confusions on kernel_thread, so I want to get help.
> > 
> > I want to create a thread in a loadable module, then I used the function
> > kernel_thread() in init_module(). Of course, the thread was created, but when
I
> > remove the module there are errors. I think it is because of the thread I
have
> > created that have not been killed. So, how can I kill this thread when I
remove
> > the module?
> 
> You can find sample-code here:
> http://ezs.kr.hsnr.de/TreiberBuch/Download/TreiberEntwickeln2004261/6-9-kthread.c
> 
>        Juergen.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


