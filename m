Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161042AbWJORjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161042AbWJORjg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 13:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161071AbWJORjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 13:39:36 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:37600 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161042AbWJORjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 13:39:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=YTnfZEuag7Oh7NhYTavraE1ZwkKdA8eUVsjoH/l4yjKUfuIo9W5DhaE1nRK2HblZ/Auuh5Zo//OvkTaxcoTXq+fNnK+UrjddDlx9J6zUW90zDVtkbq18h2Xn03xvi6sABfeA/vWrYCyORlg+fbGxpZ+m/MIhBSxydYUvoqHmWJE=
Message-ID: <45327249.2040909@gmail.com>
Date: Sun, 15 Oct 2006 21:39:21 +0400
From: Manu Abraham <abraham.manu@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Mauro Carvalho Chehab <mchehab@infradead.org>
CC: Florin Malita <fmalita@gmail.com>, Trent Piepho <xyzzy@speakeasy.org>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [v4l-dvb-maintainer] [PATCH] V4L/DVB: potential leak in	dvb-bt8xx
References: <453120EC.8030503@gmail.com>	 <Pine.LNX.4.58.0610141720560.13331@shell2.speakeasy.net>	 <45325B9E.1030808@gmail.com>  <45326359.4000502@gmail.com> <1160932715.5364.1.camel@praia>
In-Reply-To: <1160932715.5364.1.camel@praia>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab wrote:
> Em Dom, 2006-10-15 às 20:35 +0400, Manu Abraham escreveu:
>> Florin Malita wrote:
>>> Trent Piepho wrote:
>>>> I believe that 'state' will be kfree'd by the dst_attach() function if there
>>>> is a failure.  Not what you would expect, to have it allocated in the bt8xx
>>>> driver (why do is there??) and freed on error in a different function.
>>>>   
>>> Hm, you're right - it is kfreed in dst_attach(). But we're still missing
>>> the kmalloc result check...
>>>
>> This patch was applied a few days back
> 
> Yes. 
> 
> It is at:
> http://www.kernel.org/git/?p=linux/kernel/git/mchehab/v4l-dvb.git;a=commit;h=626ae83bb24927ca015503448f0199842ae2e8da

Ok.

> 
> I've already asked Linus to pull it, together with other 17 fixes, to
> Mainstream.
>> Manu
> Cheers, 
> Mauro.


Thanks,
Manu



