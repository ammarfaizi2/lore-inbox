Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbTDGEVW (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 00:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263245AbTDGEVW (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 00:21:22 -0400
Received: from air-2.osdl.org ([65.172.181.6]:45974 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263244AbTDGEVV (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 00:21:21 -0400
Message-ID: <1071.4.64.238.61.1049689975.squirrel@webmail.osdl.org>
Date: Sun, 6 Apr 2003 21:32:55 -0700 (PDT)
Subject: Re: Wanted: a limit on kernel log buffer size
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <rml@tech9.net>
In-Reply-To: <1049686794.894.13.camel@localhost>
References: <200304062137_MC3-1-3346-A97E@compuserve.com>
        <33182.4.64.238.61.1049683748.squirrel@webmail.osdl.org>
        <33271.4.64.238.61.1049686559.squirrel@webmail.osdl.org>
        <1049686794.894.13.camel@localhost>
X-Priority: 3
Importance: Normal
Cc: <rddunlap@osdl.org>, <76306.1226@compuserve.com>,
       <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11 [cvs])
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 2003-04-06 at 23:35, Randy.Dunlap wrote:
>
>> > a.  If someone won't read the help text, how can we help them?
>> >
>> > b.  If we make a 2 GB log buffer size a compile-time error, will they
>> read that?
>> >
>> > c.  If we make it a compile-time warning, will they read that?
>> >
>> > d.  What limit(s) do you suggest?  I can try to add some limits.
>> >
>> > e.  This kind of config limiting should be done in the config system
>> IMO. I've asked Roman for that capability....
>>
>> Here's a patch that limits kernel log buffer size to 1 MB max.
>> Comments?
>
> I liked points (a) and (e) above.
>
> I say if users cannot bother to read the documentation and understanding
> things, why are they compiling a kernel?
>
> And if we are going to implement parameters bounds checking it should be
> done in kconfig.  There are a few other places that want it, too.

I forgot another point:  don't change default config settings unless
you are willing to read the help text.

~Randy  [sorry if you get this multiple times; i had to resend it]




