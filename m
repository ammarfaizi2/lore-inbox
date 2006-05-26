Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932778AbWEZXf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932778AbWEZXf0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 19:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932779AbWEZXf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 19:35:26 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:31210 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932778AbWEZXf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 19:35:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=pQQGYSV0kMERJdyNQSLIvs7wVey1f9p95SyTV4dS3vMFygFGBLWG91n47J3hz4f8T0Y1htm6JhlmGd1g+EDdvyQ1Kzp2Fde0O+R4aorDy1jd6a9bacK8DnMLDT0QQ/3azWojZHuAknFVVP3U1Oy6Yyk/X0A+JEmr77BfECJ1sQc=
Message-ID: <447790BB.4060707@gmail.com>
Date: Sat, 27 May 2006 02:35:23 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6-7.5.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: dtor_core@ameritech.net, linux-joystick@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 03/13] input: make input a multi-object module
References: <20060526161129.557416000@gmail.com>	<20060526162902.227348000@gmail.com>	<20060526141603.054f0459.akpm@osdl.org>	<44777340.7030905@gmail.com>	<20060526144309.60469bcd.akpm@osdl.org>	<447778DA.8080507@gmail.com>	<20060526150804.0ae11b1f.akpm@osdl.org>	<44777F98.4080004@gmail.com>	<20060526153246.267991ed.akpm@osdl.org>	<44778A14.4060500@gmail.com> <20060526162842.4da6b447.akpm@osdl.org>
In-Reply-To: <20060526162842.4da6b447.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Anssi Hannula <anssi.hannula@gmail.com> wrote:
> 
>>Unless you have any more thoughts, I'll make patches for (1) separate
>>input-ff.o from input.o so that input.c renaming is not required, and to
>>(2) use the input_dev->event() handler instead of input.o calling
>>input-ff.o.
> 
> 
> Sounds good, thanks.

Hmh, I guess I need to send the modified "input: new force feedback
interface" patch fully again, as the previous patch patches input-core.c
that doesn't exist if we drop the rename.

A final minor question: In your opinion is input-ff.c or ff-effects.c a
better name? ;)

-- 
Anssi Hannula

