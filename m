Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265232AbUF1VTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265232AbUF1VTO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 17:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbUF1VTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 17:19:13 -0400
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:9483 "EHLO
	zcamail03.zca.compaq.com") by vger.kernel.org with ESMTP
	id S265236AbUF1VSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 17:18:03 -0400
Message-ID: <40E08C46.6050302@hp.com>
Date: Mon, 28 Jun 2004 17:23:18 -0400
From: Robert Picco <Robert.Picco@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hpet related
References: <40E05EC2.20700@hp.com> <20040628132704.50874705.akpm@osdl.org>
In-Reply-To: <20040628132704.50874705.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sure.  I'll make the change and resend patch.
Andrew Morton wrote:

>Robert Picco <Robert.Picco@hp.com> wrote:
>  
>
>>+static inline void hpet_timer_reserved(struct hpet_data *hd, int timer)
>> +{
>> +	hd->hd_state |= (1 << timer);
>> +	return;
>> +}
>>    
>>
>
>The identifier "hpet_timer_reserved" implies (to me) that the function
>queries something.  Except it doesn't.
>
>Would "hpet_reserve_timer" be a better choice?
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


