Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261524AbSKTRfS>; Wed, 20 Nov 2002 12:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261559AbSKTRfS>; Wed, 20 Nov 2002 12:35:18 -0500
Received: from mailhost.cotse.com ([216.112.42.58]:56077 "EHLO
	mailhost.cotse.com") by vger.kernel.org with ESMTP
	id <S261524AbSKTRfR>; Wed, 20 Nov 2002 12:35:17 -0500
Message-ID: <YWxhbg==.a52cc26fdfc7be55a9c71089486d66e7@1037814068.cotse.net>
Date: Wed, 20 Nov 2002 12:41:08 -0500 (EST)
X-Abuse-To: abuse@cotse.com
Subject: Re: MAX_ARG_PAGES
From: "Alan Willis" <alan@cotse.net>
To: <jonathan.sambrook@dsvr.co.uk>
In-Reply-To: <20021120161819.GA9932@jsambrook>
References: <YWxhbg==.fbe902c8c023f46b8c6a468b793820bf@1037755344.cotse.net>
        <20021120161819.GA9932@jsambrook>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <linux-kernel@vger.kernel.org>
Reply-To: alan@cotse.com
X-Mailer: www.cotse.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   Thanks.  I don't subscribe to lkml, so I missed this.  It would be nice
if this was made tunable via sysctl, as was suggested in the thread you
pointed me to.

Tricks to get around it in userspace are a rather fun exercise though :o)

-alan

> At 20:22 on Tue 19/11/02, alan@cotse.net masquerading as 'Alan Willis'
> wrote:
>>
>>    Recently I had a user who needed to remove 17k files all at once
>> and
>> received the message 'rm: Argument list too long'.  In his case an rm
>> -rf on the directory itself solved his problem, but after a quick web
>> search, it seems that the value of MAX_ARG_PAGES in
>> include/linux/binfmts.h (32) is responsible for this limitation.
>> Could this value possibly be increased safely?  I'm curious, is there
>> some other limitation that has been breached in the 2.5 series that
>> would make it safer to increase MAX_ARG_PAGES?
>
> See lkml passim (circa 3:30pm 12 Nov 2002 starting with a message from
> Adam Voigt)
>
>
> --
>
>  Jonathan Sambrook
> Software  Developer
>  Designer  Servers



