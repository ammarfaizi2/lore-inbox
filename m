Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292409AbSBPJaX>; Sat, 16 Feb 2002 04:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292398AbSBPJaN>; Sat, 16 Feb 2002 04:30:13 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:35081 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S292385AbSBPJaE>; Sat, 16 Feb 2002 04:30:04 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: Disgusted with kbuild developers
Date: 16 Feb 2002 07:41:17 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrna6s38t.oes.kraxel@bytesex.org>
In-Reply-To: <E16br21-0004Vw-00@the-village.bc.nu> <3C6DE6A1.2B5717BE@mandrakesoft.com>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1013845277 25752 127.0.0.1 (16 Feb 2002 07:41:17 GMT)
User-Agent: slrn/0.9.7.1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
>  Alan Cox wrote:
> > Since the information is there in CML1 to generate the list of constraints
> > for any given option, its a reasonable assertion that the entire CML2
> > language rewrite is self indulgence from a self confessed language invention
> > freak.
>  
>  Correct me if I'm wrong, but there are express two different types of
>  situations, and CML1 isn't sufficient to express the second:
>  
>  1) CONFIG_FOO_OPTION requires CONFIG_FOO
>  
>  2) CONFIG_SUBSYS2 requires CONFIG_SUBSYS1
>  
>  The reason why #2 is different, is the desired prompting and symbol
>  behavior for the end user.
>  
>  If CONFIG_SUBSYS1=m or "", and CONFIG_SUBSYS2=y or m, then we gotta
>  change the value of CONFIG_SUBSYS1 and options underneath
>  CONFIG_SUBSYS1.  Re-prompt for CONFIG_SUBSYS1, perhaps?

IMHO that is a issue with the current *tools*, not with the CML1
*language*.  The information about the dependences is there, a more
clever tool than "make config" can use them to present a better UI.

I have a 5-year-old perl script for kernel configuration, maybe
I should try to reactivate it and see ...

  Gerd

-- 
#define	ENOCLUE 125 /* userland programmer induced race condition */
