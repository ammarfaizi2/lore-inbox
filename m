Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317287AbSFGOud>; Fri, 7 Jun 2002 10:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317293AbSFGOuc>; Fri, 7 Jun 2002 10:50:32 -0400
Received: from users.ccur.com ([208.248.32.211]:20103 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id <S317287AbSFGOuc>;
	Fri, 7 Jun 2002 10:50:32 -0400
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200206071449.OAA16511@rudolph.ccur.com>
Subject: Re: [PATCH] 2.4.19-pre10 bug in disable_APIC_timer
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 7 Jun 2002 10:49:31 -0400 (EDT)
Cc: joe.korty@ccur.com (Joe Korty), marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org
Reply-To: joe.korty@ccur.com (Joe Korty)
In-Reply-To: <1023463436.25523.35.camel@irongate.swansea.linux.org.uk> from "Alan Cox" at Jun 07, 2002 04:23:56 PM
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Thu, 2002-06-06 at 21:59, Joe Korty wrote:
>> Marcelo,
>>  This one bit me when I actually started using the (relatively) new
>> services disable_APIC_timer() and enable_APIC_timer().  Enable_APIC_timer()
>> is coded correctly; this patch fixes the bug in the disable service.
> 
> When is this getting called from a non boot up situation ?


I am calling it from some cpu shielding code I've written and am
debugging.

Joe
