Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWJHWET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWJHWET (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 18:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWJHWET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 18:04:19 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:35886 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751491AbWJHWES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 18:04:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cUpNngXutSlGfwiKhGgjs+R7nXSTr3nyfPLsPRCzr953n6xzFKSyLHdMem625WU8jRyXbf12KJ4TFm7xBL2Q2ZmR2ee/T3JIa3mPbAX1cwoqkmUNT+26bVRQoaHyjb+NEiC9GMGfcGKNnDWq9C3Bd4F3bs+1o4lQs2bIVZcKSzI=
Message-ID: <20f65d530610081504o3a72f654pf60cb9e0278bf2e0@mail.gmail.com>
Date: Mon, 9 Oct 2006 11:04:18 +1300
From: "Keith Chew" <keith.chew@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BIOS THRM-Throttling and driver timings
In-Reply-To: <1160343907.3000.183.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20f65d530610030729o42658bd6hcc204f8deac4a33e@mail.gmail.com>
	 <1159886437.2891.532.camel@laptopd505.fenrus.org>
	 <20061008211821.GA4280@elf.ucw.cz>
	 <1160343907.3000.183.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

> > in general linux should be ok with this happening. However for specific
> > cases... you'll need to provide more information; you're not
> > mentioning
>
> Really? AFAICT P4 will happily slow down behind our backs, making at
> least udelays() with interrupts disabled sleep for too long.
>

I believe we are seeing similar behaviours with the drivers. As a
temporary workaround, we have asked the manufacturers to supply us
with a BIOS that disabled THRM-Throttling. So far, things are looking
good, but we are still doing more testing.

> > (also: if you actually HIT throttling, there is something very very
> > wrong; you're not supposed to hit that unless the fan is defective, but
> > never in "normal" healthy operation. If you do hit it without hardware
> > defects then there is most likely a fundamental airflow problem you'll
> > want to fix urgently)
>
> At least in toshiba notebook, I was hitting thermal throttling even
> through both fans were okay. There are many misdesigned machines out
> there, I fear.

In our case, we are running the unit in mobile environment, with not
much ventilation. In our test environment, the unit runs fine at
temperatures of 80-90 degrees. In the real environment, we only expect
temperatures of 50-70 degrees.

Regards
Keith
