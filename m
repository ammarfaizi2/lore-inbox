Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVBZRHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVBZRHG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 12:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVBZRHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 12:07:06 -0500
Received: from lantana.tenet.res.in ([202.144.28.166]:6866 "EHLO
	lantana.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S261234AbVBZRHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 12:07:00 -0500
Date: Sat, 26 Feb 2005 22:36:57 +0530 (IST)
From: Payasam Manohar <pmanohar@lantana.cs.iitm.ernet.in>
To: Parag Warudkar <kernel-stuff@comcast.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: how to use schedule_work()
In-Reply-To: <022620051659.7657.4220AAE60003033B00001DE9220588448400009A9B9CD3040A029D0A05@comcast.net>
Message-ID: <Pine.LNX.4.60.0502262235560.18124@lantana.cs.iitm.ernet.in>
References: <022620051659.7657.4220AAE60003033B00001DE9220588448400009A9B9CD3040A029D0A05@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Mail-scanner Found to be clean
X-MailScanner-From: pmanohar@lantana.cs.iitm.ernet.in
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hai,
     Thanks for the information.






   Thanks&Regards,
    KernelNewbie.

  eb 2005, Parag Warudkar wrote:

>>
>> hai all,
>>     I want to call call_usermodehelper() from schedule_work() to run the
>> user program in the process context. Can u please tell me how to call
>> schedule_work(), plz give any reference manual for that.
>>
> Download cscope from cscope.sourceforge.net - The site has a good tutorial on using it with linux kernel. (It's a source code searching tool - you can find for example, all functions that call a particular function and so on.) I find it very useful when you want to understand things from source code.
>
> Then find for schedule_work, look into the source where it is used and see if you can comprehend it that way.
>
> In essence - you need to setup and initialize a struct work_struct (this cannot be on a function local stack since callers stack will not be available when the work is executed) fill it with function to be called and arguments to be passed and then call schedule_work from say an interrupt.
>
> Parag
>
>
>
