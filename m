Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288959AbSAYX72>; Fri, 25 Jan 2002 18:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290835AbSAYX7S>; Fri, 25 Jan 2002 18:59:18 -0500
Received: from khms.westfalen.de ([62.153.201.243]:65171 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S290834AbSAYX7H>; Fri, 25 Jan 2002 18:59:07 -0500
Date: 25 Jan 2002 21:02:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8HYG7RLmw-B@khms.westfalen.de>
In-Reply-To: <200201250900.g0P8xoL10082@home.ashavan.org.>
Subject: Re: RFC: booleans and the kernel
X-Mailer: CrossPoint v3.12d.kh8 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <8HXjQ8omw-B@khms.westfalen.de> <1011911932.810.23.camel@phantasy> <200201242243.g0OMhAL06878@home.ashavan.org.> <8HXjQ8omw-B@khms.westfalen.de> <200201250900.g0P8xoL10082@home.ashavan.org.>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

timothy.covell@ashavan.org (Timothy Covell)  wrote on 26.01.02 in <200201250900.g0P8xoL10082@home.ashavan.org.>:

> On Friday 25 January 2002 00:36, Kai Henningsen wrote:

> > We're talking about a specific language feature, and that feature isn't
> > what you seem to be thinking it is. It does not change anything you can do
> > with ints.
>
> I know, I was talking about typographical errors such as:
>
> int x=0;
>
> if ( x = 1 )
>
>
> or
>
> char x;
> if ( x )
>
> which did not product the desired results.  My thought was to encourage the
> use of booleans instead of ints in these kinds of conditionals.   I thought

And if you changed the int and/or the char into bool, this would  
accomplish exactly nothing. A compiler can warn about assignments in  
conditions or uninitialized variables, and gcc does it already (and has  
done so since a long time); why you think this has anything to do with  
bool seems to be completely unclear to everyone but you.

> admits that there are benefits too.  But, I think it amazing that I'm being
> told that I'm an idiot when even the language's author agrees with me
> on my concerns about C.

Of course, that is again not what is happening. You either *weren't*  
talking about Richie's concerns, or else you were making an excellent  
effort of keeping that fact secret from the rest of us.

What you *were* saying is that you think bool would help get warnings that  
you *already* get and that bool has absolutely no relevance to. I didn't  
exactly call you an idiot for that, but that is certainly the impression  
you left.

MfG Kai
