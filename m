Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVCADlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVCADlF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 22:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVCADlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 22:41:05 -0500
Received: from lantana.tenet.res.in ([202.144.28.166]:21479 "EHLO
	lantana.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S261223AbVCADlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 22:41:01 -0500
Date: Tue, 1 Mar 2005 09:11:14 +0530 (IST)
From: Payasam Manohar <pmanohar@lantana.cs.iitm.ernet.in>
To: Lee Revell <rlrevell@joe-job.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: user space program from keyboard driver
In-Reply-To: <1109625676.9273.26.camel@mindpipe>
Message-ID: <Pine.LNX.4.60.0503010907430.11396@lantana.cs.iitm.ernet.in>
References: <Pine.LNX.4.60.0502282118480.2017@lantana.cs.iitm.ernet.in>
 <1109625676.9273.26.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Mail-scanner Found to be clean
X-MailScanner-From: pmanohar@lantana.cs.iitm.ernet.in
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks.My work is not writing keystroke logger, I know about it, but I 
want to call some other program which will run in bash ,and get some data 
from user mode and return to kernel mode on demand,
which can be called from keyboard driver.





   Thanks&Regards,

   P.Manohar,


On Mon, 28 Feb 2005, Lee Revell wrote:

> On Mon, 2005-02-28 at 21:24 +0530, Payasam Manohar wrote:
>> hai all,
>>     I am a newbie to kernel, I want to work on linux kernel modules.
>> My task is to call a user program from keyboard driver under certain
>> conditions. I know that we can call user program using
>> call_usermodehelper(), but we can not call it direcly from driver as it is
>> a interrupt context. So we need to call using schedule_work(). But I need
>> more clarification on these points. How to call user program from the
>> keyboard driver. Please give ur ideas for doing this.
>>
>
> Are you just trying to write a keystroke logger?
>
> Lee
>
