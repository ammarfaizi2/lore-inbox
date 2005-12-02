Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbVLBRHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbVLBRHI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 12:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbVLBRHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 12:07:08 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:14527 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750713AbVLBRHH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 12:07:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wt49iyZ2/6anSSBWfX673gswTwBkL47mox7VOkfzyGFyKR919ctciN9HRIwgJs2Dlr7fhb01YccyNgPrdSVBDwQZSjARKZW6UrTtu5+dtZimUiOxhA3Vpy4hcnLQCDcC1FBBD4nZ/98eDTeiG9pPvo1eORCecYplhjMNfQMlanU=
Message-ID: <2cd57c900512020907h4be23519q@mail.gmail.com>
Date: Sat, 3 Dec 2005 01:07:04 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Use enum to declare errno values
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Paul Jackson <pj@sgi.com>, francis_moreau2000@yahoo.fr,
       linux-kernel@vger.kernel.org
In-Reply-To: <4390730F.8000909@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051123132443.32793.qmail@web25813.mail.ukl.yahoo.com>
	 <20051123233016.4a6522cf.pj@sgi.com>
	 <Pine.LNX.4.61.0512011458280.21933@chaos.analogic.com>
	 <200512020849.28475.vda@ilport.com.ua>
	 <2cd57c900512020127m5c7ca8e1u@mail.gmail.com>
	 <4390730F.8000909@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/12/3, Bill Davidsen <davidsen@tmr.com>:
> Coywolf Qi Hunt wrote:
>
> > This is a reason why enums are worse than #defines.
> >
> > Unlike in other languages, C enum is not much useful in practices.
>
> Actually they are highly useful if you know how to use them. They allow
> type checking, have auto increment, and are part of the language instead
>   of a feature of the preprocessor.

Yes, I know type checking and auto increment. But they are not
worthwhile, at least not for serious C programming. No, I don't know
how to use them comfortably.

What's wrong with sorted macros? They are more flexible and readable.
enums just look weird. We also share macros b/w C and asm.

You words on language and preprocessor doesn't make any sense.
It's not a feature of the preprocessor, it's what cpp is for. Look, I
call it Cpp. Without this `feature', what would a C preprocessor do?
You've castrated cpp.

Follow you logic, C standard should only specify C language, not
anything of libc...  I have no interest in arguing the relations b/w C
and cpp.

>
> > Maybe the designer wanted C to be as fancy as other languages?  C
> > shouldn't have had enum imho. Anyway we don't have any strong motives
> > to switch to enums.
>
> The last sentence seems correct in spite of your misunderstanding of how
> and why enums are used and useful. Like a driver who mis-read a map
> wandering aimlessly and lost, you have come to the correct destination
> by accident.

lol

>
> It would have been good to use enums in the first place, I can't see
> changing now because of the effort involved.

You contradict yourself rather.

--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
