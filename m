Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290544AbSARAFj>; Thu, 17 Jan 2002 19:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290545AbSARAF3>; Thu, 17 Jan 2002 19:05:29 -0500
Received: from f131.law11.hotmail.com ([64.4.17.131]:17163 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S290544AbSARAFX>;
	Thu, 17 Jan 2002 19:05:23 -0500
X-Originating-IP: [156.153.254.2]
From: "Balbir Singh" <balbir_soni@hotmail.com>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Suspected bug in getpeername and getsockname
Date: Thu, 17 Jan 2002 16:05:17 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F131HApBClrdudfwG9t000112bd@hotmail.com>
X-OriginalArrivalTime: 18 Jan 2002 00:05:17.0474 (UTC) FILETIME=[CFA4F020:01C19FB3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Can the user eat up more than a scheduling quantum because of the
>work done by ->getname()?  I certainly don't think you can prove
>this.
>

That depends on what ->getname() does. Anyway
in my opinion any code which does all the processing
and then catches any error is BROKEN.

>It certainly isn't work the long discussion we're having about it,
>that is for sure.
>

I agree! no point

>You want this to make your broken getname() protocol semantics work
>and I'd like you to address that instead.  I get the feeling that
>you've designed this weird behavior and that it is not specified in
>any standard anyways that your protocol must behave in this way.  I
>suggest you change it to work without the user length being
>available.
>

There is no other choice but to live with it.

Regards,
Balbir

_________________________________________________________________
MSN Photos is the easiest way to share and print your photos: 
http://photos.msn.com/support/worldwide.aspx

