Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262247AbULMMpC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262247AbULMMpC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 07:45:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbULMMpC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 07:45:02 -0500
Received: from postman1.arcor-online.net ([151.189.20.156]:44190 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S262247AbULMMov
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 07:44:51 -0500
Date: Mon, 13 Dec 2004 13:44:26 +0100
From: Juergen Quade <quade@hsnr.de>
To: Zhenyu Wu <y030729@njupt.edu.cn>
Cc: linux-kernel@vger.kernel.org
Subject: Re: about kernel_thread!
Message-ID: <20041213124426.GA4157@hsnr.de>
References: <302943559.21891@njupt.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <302943559.21891@njupt.edu.cn>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 09:12:39PM +0800, Zhenyu Wu wrote:
> Hello, 
> 
> I have some confusions on kernel_thread, so I want to get help.
> 
> I want to create a thread in a loadable module, then I used the function
> kernel_thread() in init_module(). Of course, the thread was created, but when I
> remove the module there are errors. I think it is because of the thread I have
> created that have not been killed. So, how can I kill this thread when I remove
> the module?

You can find sample-code here:
http://ezs.kr.hsnr.de/TreiberBuch/Download/TreiberEntwickeln2004261/6-9-kthread.c

       Juergen.
